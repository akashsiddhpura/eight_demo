// lib/widgets/seek_bar.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/audio_bloc.dart';

class SeekBar extends StatefulWidget {
  @override
  _SeekBarState createState() => _SeekBarState();
}

class _SeekBarState extends State<SeekBar> {
  double? _dragValue;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioBloc, AudioState>(
      builder: (context, state) {
        final duration = state.mediaItem?.duration?.inSeconds.toDouble() ?? 0.0;
        final position = _dragValue ?? state.position.inSeconds.toDouble();

        if (duration <= 0) {
          return const SizedBox.shrink();
        }

        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatDuration(Duration(seconds: position.round())),
                  style: TextStyle(color: Colors.white.withOpacity(0.7)),
                ),
                Text(
                  _formatDuration(Duration(seconds: duration.round())),
                  style: TextStyle(color: Colors.white.withOpacity(0.7)),
                ),
              ],
            ),
            SliderTheme(
              data: SliderThemeData(
                trackShape: CustomTrackShape(),
                thumbShape: const RoundSliderThumbShape(
                  disabledThumbRadius: 8,
                  enabledThumbRadius: 8,
                ),
              ),
              child: Slider(
                value: position.clamp(0.0, duration),
                min: 0.0,
                max: duration,
                onChanged: (value) {
                  setState(() {
                    _dragValue = value;
                  });
                },
                onChangeEnd: (value) {
                  setState(() {
                    _dragValue = null;
                  });
                  context.read<AudioBloc>().add(SeekAudioEvent(Duration(seconds: value.toInt())));
                },
                inactiveColor: Colors.grey.withOpacity(.3),
                activeColor: Colors.red,
                thumbColor: Colors.white,
              ),
            ),
          ],
        );
      },
    );
  }

  String _formatDuration(Duration duration) {
    return [duration.inMinutes, duration.inSeconds % 60].map((seg) => seg.toString().padLeft(2, '0')).join(':');
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double? trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop = offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
