// lib/bloc/audio_event.dart
part of 'audio_bloc.dart';

abstract class AudioEvent extends Equatable {
  const AudioEvent();

  @override
  List<Object?> get props => [];
}

class PlayerBgChangeEvent extends AudioEvent {
  final Color color;

  const PlayerBgChangeEvent(this.color);
}

class LoadPlaylistEvent extends AudioEvent {
  final List<MediaItem> playlist;
  final int index;

  LoadPlaylistEvent(this.playlist, {this.index = 0});
}

class PlayPauseEvent extends AudioEvent {}

class RewindEvent extends AudioEvent {}

class FastForwardEvent extends AudioEvent {}

class NextTrackEvent extends AudioEvent {}

class PreviousTrackEvent extends AudioEvent {}

class UpdateCurrentMediaItemEvent extends AudioEvent {
  final MediaItem? mediaItem;

  UpdateCurrentMediaItemEvent({required this.mediaItem});
}

class UpdatePlaybackStateEvent extends AudioEvent {
  final bool isPlaying;
  final Duration position;

  UpdatePlaybackStateEvent({required this.isPlaying, required this.position});

  @override
  List<Object?> get props => [isPlaying, position];
}

class SeekAudioEvent extends AudioEvent {
  final Duration position;

  SeekAudioEvent(this.position);

  @override
  List<Object?> get props => [position];
}