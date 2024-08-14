// lib/widgets/player_controls.dart
import 'package:eight_demo/common/app_colors.dart';
import 'package:eight_demo/presentation/bloc/audio_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayPauseButton extends StatelessWidget {
  const PlayPauseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.white, width: 2),
      ),
      child: BlocBuilder<AudioBloc, AudioState>(
        builder: (context, state) {
          return IconButton(
            icon: Icon(state.isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded),
            color: AppColors.white,
            iconSize: 35,
            onPressed: () {
              context.read<AudioBloc>().add(PlayPauseEvent());
            },
          );
        },
      ),
    );
  }
}

class RewindButton extends StatelessWidget {
  const RewindButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.replay_10_rounded),
      color: AppColors.white,
      iconSize: 35,
      onPressed: () {
        context.read<AudioBloc>().add(RewindEvent());
      },
    );
  }
}

class FastForwardButton extends StatelessWidget {
  const FastForwardButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.forward_10_rounded),
      color: AppColors.white,
      iconSize: 35,
      onPressed: () {
        context.read<AudioBloc>().add(FastForwardEvent());
      },
    );
  }
}

class NextButton extends StatelessWidget {
  const NextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.skip_next_rounded),
      color: AppColors.white,
      iconSize: 35,
      onPressed: () {
        context.read<AudioBloc>().add(NextTrackEvent());
      },
    );
  }
}

class PreviousButton extends StatelessWidget {
  const PreviousButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.skip_previous_rounded),
      color: AppColors.white,
      iconSize: 35,
      onPressed: () {
        context.read<AudioBloc>().add(PreviousTrackEvent());
      },
    );
  }
}

class SleepTimerButton extends StatelessWidget {
  const SleepTimerButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.timer_outlined),
      color: AppColors.grey,
      iconSize: 30,
      onPressed: () {},
    );
  }
}

class SpeedButton extends StatelessWidget {
  const SpeedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Text(
        "1X",
        style: TextStyle(color: AppColors.grey, fontWeight: FontWeight.bold, fontSize: 22),
      ),
      onPressed: () {},
    );
  }
}

class ShareButton extends StatelessWidget {
  const ShareButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.share_outlined),
      color: AppColors.grey,
      iconSize: 25,
      onPressed: () {},
    );
  }
}

class LikeButton extends StatelessWidget {
  const LikeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          icon: const Icon(CupertinoIcons.heart),
          color: AppColors.grey,
          iconSize: 25,
          visualDensity: const VisualDensity(vertical: -4),
          onPressed: () {},
        ),
        Text("1K", style: TextStyle(color: AppColors.grey, fontWeight: FontWeight.bold, fontSize: 8)),
      ],
    );
  }
}
