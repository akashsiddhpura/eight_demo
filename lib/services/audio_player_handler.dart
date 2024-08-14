// lib/services/audio_player_handler.dart
import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

import '../data/audio_data.dart';

class AudioPlayerHandler extends BaseAudioHandler with SeekHandler {
  final _player = AudioPlayer();
  final _playlist = ConcatenatingAudioSource(children: []);
  final _mediaLibrary = MediaLibrary();
  final BehaviorSubject<List<MediaItem>> _recentSubject = BehaviorSubject.seeded(<MediaItem>[]);

  AudioPlayerHandler() {
    _init();
  }

  Future<void> _init() async {
    _player.setAudioSource(_playlist);

    queue.add(_mediaLibrary.items[MediaLibrary.albumsRootId]!);

    mediaItem.whereType<MediaItem>().listen((item) => _recentSubject.add([item]));
    // Broadcast media item changes.
    _player.currentIndexStream.listen((index) {
      if (index != null) mediaItem.add(queue.value[index]);
    });
    _player.playbackEventStream.listen(_broadcastState);


    _player.processingStateStream.listen((state) {
      if (state == ProcessingState.completed) stop();
    });
    try {
      // After a cold restart (on Android), _player.load jumps straight from
      // the loading state to the completed state. Inserting a delay makes it
      // work. Not sure why!
      //await Future.delayed(Duration(seconds: 2)); // magic delay
      await _player.setAudioSource(ConcatenatingAudioSource(
        children: queue.value.map((item) => AudioSource.uri(Uri.parse(item.id))).toList(),
      ));
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> addQueueItems(List<MediaItem> mediaItems) async {
    final sources = mediaItems.map((item) => AudioSource.uri(Uri.parse(item.id), tag: item)).toList();
    _playlist.addAll(sources);
    queue.add(mediaItems);
  }

  @override
  Future<List<MediaItem>> getChildren(String parentMediaId, [Map<String, dynamic>? options]) async {
    switch (parentMediaId) {
      case AudioService.recentRootId:
        // When the user resumes a media session, tell the system what the most
        // recently played item was.
        return _recentSubject.value;
      default:
        // Allow client to browse the media library.
        return _mediaLibrary.items[parentMediaId]!;
    }
  }

  @override
  ValueStream<Map<String, dynamic>> subscribeToChildren(String parentMediaId) {
    switch (parentMediaId) {
      case AudioService.recentRootId:
        final stream = _recentSubject.map((_) => <String, dynamic>{});
        return _recentSubject.hasValue ? stream.shareValueSeeded(<String, dynamic>{}) : stream.shareValue();
      default:
        return Stream.value(_mediaLibrary.items[parentMediaId]).map((_) => <String, dynamic>{}).shareValue();
    }
  }

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> stop() async {
    await _player.stop();
    playbackState.add(playbackState.value.copyWith(
      controls: [],
      processingState: AudioProcessingState.idle,
      playing: false,
    ));
    await super.stop();
  }

  @override
  Future<void> skipToNext() => _player.seekToNext();

  @override
  Future<void> skipToPrevious() => _player.seekToPrevious();

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Future<void> rewind() async {
    await _player.seek(
      Duration(seconds: _player.position.inSeconds - 10),
    );
  }

  @override
  Future<void> fastForward() async {
    await _player.seek(
      Duration(seconds: _player.position.inSeconds + 10),
    );
  }

  void _broadcastState(PlaybackEvent event) {
    final playing = _player.playing;
    playbackState.add(playbackState.value.copyWith(
      controls: [
        MediaControl.rewind,
        if (playing) MediaControl.pause else MediaControl.play,
        MediaControl.stop,
        MediaControl.fastForward,
      ],
      systemActions: const {
        MediaAction.seek,
        MediaAction.seekForward,
        MediaAction.seekBackward,
      },
      androidCompactActionIndices: const [0, 1, 3],
      processingState: const {
        ProcessingState.idle: AudioProcessingState.idle,
        ProcessingState.loading: AudioProcessingState.loading,
        ProcessingState.buffering: AudioProcessingState.buffering,
        ProcessingState.ready: AudioProcessingState.ready,
        ProcessingState.completed: AudioProcessingState.completed,
      }[_player.processingState]!,
      playing: playing,
      updatePosition: _player.position,
      bufferedPosition: _player.bufferedPosition,
      speed: _player.speed,
      queueIndex: event.currentIndex,
    ));
  }
}
