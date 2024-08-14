// lib/bloc/audio_state.dart
part of 'audio_bloc.dart';

class AudioState extends Equatable {
  final MediaItem? mediaItem;
  final bool isPlaying;
  final Duration position;
  final Color bgColor;

  AudioState({this.mediaItem, this.isPlaying = false, this.position = Duration.zero,this.bgColor = Colors.black});

  AudioState copyWith({MediaItem? mediaItem, bool? isPlaying, Duration? position, Color? bgColor}) {
    return AudioState(
      mediaItem: mediaItem ?? this.mediaItem,
      isPlaying: isPlaying ?? this.isPlaying,
      position: position ?? this.position,
      bgColor: bgColor ?? this.bgColor
    );
  }

  @override
  List<Object?> get props => [mediaItem, isPlaying, position, bgColor];
}

class AudioInitial extends AudioState {}
