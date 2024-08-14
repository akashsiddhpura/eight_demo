import 'package:eight_demo/common/app_colors.dart';
import 'package:eight_demo/common/size_extention.dart';
import 'package:eight_demo/presentation/widget/player_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/audio_bloc.dart';
import '../widget/player_bg_widget.dart';
import '../widget/seek_bar.dart';

class AudioPlayerScreen extends StatefulWidget {
  const AudioPlayerScreen({super.key});

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  @override
  Widget build(BuildContext context) {
    return PlayerBgWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Audio Player'),
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              /// Image
              Expanded(
                child: Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8.h),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.white, width: 2),
                    ),
                    child: BlocBuilder<AudioBloc, AudioState>(
                      builder: (context, state) {
                        return Image.network(
                          state.mediaItem?.artUri.toString() ?? '',
                          height: 55.w,
                          width: 55.w,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),
              ),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Title and Artist
                    BlocBuilder<AudioBloc, AudioState>(
                      builder: (context, state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.mediaItem?.album ?? 'No title',
                              style: TextStyle(color: AppColors.grey),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              state.mediaItem?.title ?? 'No title',
                              style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w500, fontSize: 18),
                              maxLines: 2,
                            ),
                          ],
                        );
                      },
                    ),

                    SizedBox(
                      height: 5.h,
                    ),

                    /// Player Controller
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        PreviousButton(),
                        RewindButton(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: PlayPauseButton(),
                        ),
                        FastForwardButton(),
                        NextButton(),
                      ],
                    ),

                    /// SeekBar
                    SeekBar(),

                    /// Player Controller
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SleepTimerButton(),
                        SpeedButton(),
                        ShareButton(),
                        SizedBox(),
                        LikeButton(),
                      ],
                    ),
                    const Spacer(),

                    /// Playlist
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.playlist_play_rounded,
                            color: AppColors.white,
                            size: 25,
                          ),
                          Text(
                            "Episodes",
                            style: TextStyle(color: AppColors.grey),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
