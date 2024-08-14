// lib/bloc/audio_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:audio_service/audio_service.dart';
import 'package:equatable/equatable.dart';
import 'package:palette_generator/palette_generator.dart';

part 'audio_event.dart';
part 'audio_state.dart';

class AudioBloc extends Bloc<AudioEvent, AudioState> {
  final AudioHandler _audioHandler = GetIt.I<AudioHandler>();

  AudioBloc() : super(AudioInitial()) {
    on<LoadPlaylistEvent>(_onLoadPlaylist);
    on<PlayPauseEvent>(_onPlayPause);
    on<RewindEvent>(_onRewind);
    on<FastForwardEvent>(_onFastForward);
    on<NextTrackEvent>(_onNextTrack);
    on<PreviousTrackEvent>(_onPreviousTrack);
    on<SeekAudioEvent>(_onSeekAudio);
    on<UpdateCurrentMediaItemEvent>(_onUpdateCurrentMediaItem);
    on<UpdatePlaybackStateEvent>(_onUpdatePlaybackState);

    _audioHandler.playbackState.listen((state) {
      add(UpdatePlaybackStateEvent(isPlaying: state.playing, position: state.position));
    });

    _audioHandler.mediaItem.listen((item) {
      add(UpdateCurrentMediaItemEvent(mediaItem: item));
    });
  }

  void _onLoadPlaylist(LoadPlaylistEvent event, Emitter<AudioState> emit) async {
    await _audioHandler.addQueueItems(event.playlist);
    Color bgColor = await _changeBgColor(event.playlist[event.index]);
    // add(PlayPauseEvent());
    emit(state.copyWith(mediaItem: event.playlist[event.index], isPlaying: state.isPlaying, position: state.position, bgColor: bgColor));
  }

  void _onPlayPause(PlayPauseEvent event, Emitter<AudioState> emit) async {
    if (_audioHandler.playbackState.value.playing) {
      await _audioHandler.pause();
    } else {
      await _audioHandler.play();
    }
  }

  void _onRewind(RewindEvent event, Emitter<AudioState> emit) async {
    await _audioHandler.rewind();
  }

  void _onFastForward(FastForwardEvent event, Emitter<AudioState> emit) async {
    await _audioHandler.fastForward();
  }

  void _onNextTrack(NextTrackEvent event, Emitter<AudioState> emit) async {
    await _audioHandler.skipToNext();
    Color bgColor = await _changeBgColor(state.mediaItem);
    if (state.isPlaying) {
      await _audioHandler.play();
    }
    emit(state.copyWith(position: state.position, bgColor: bgColor));
  }

  void _onPreviousTrack(PreviousTrackEvent event, Emitter<AudioState> emit) async {
    await _audioHandler.skipToPrevious();
    Color bgColor = await _changeBgColor(state.mediaItem);
    if (state.isPlaying) {
      await _audioHandler.play();
    }
    emit(state.copyWith(position: state.position, bgColor: bgColor));
  }

  void _onSeekAudio(SeekAudioEvent event, Emitter<AudioState> emit) async {
    await _audioHandler.seek(event.position);
  }

  void _onUpdateCurrentMediaItem(UpdateCurrentMediaItemEvent event, Emitter<AudioState> emit) {
    emit(state.copyWith(mediaItem: event.mediaItem));
  }

  void _onUpdatePlaybackState(UpdatePlaybackStateEvent event, Emitter<AudioState> emit) {
    emit(state.copyWith(isPlaying: event.isPlaying, position: event.position));
  }

  Color defaultColor = Colors.black;
  PaletteGenerator? paletteGenerator;

  Future<Color> _changeBgColor(MediaItem? mediaItem) async {
    paletteGenerator = await PaletteGenerator.fromImageProvider(NetworkImage(mediaItem!.artUri!.toString()));

    if (paletteGenerator!.darkMutedColor != null) {
      Color updatedColor = paletteGenerator!.darkMutedColor!.color;

      return updatedColor;
    }
    return defaultColor;
  }

  @override
  Future<void> close() {
    _audioHandler.stop();
    return super.close();
  }
}
