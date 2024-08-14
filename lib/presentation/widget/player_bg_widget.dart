import 'package:eight_demo/presentation/bloc/audio_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayerBgWidget extends StatefulWidget {
  final Widget child;
  const PlayerBgWidget({super.key, required this.child});

  @override
  State<PlayerBgWidget> createState() => _PlayerBgWidgetState();
}

class _PlayerBgWidgetState extends State<PlayerBgWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: BlocBuilder<AudioBloc, AudioState>(
        builder: (context, state) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  state.bgColor,
                  state.bgColor,
                  Colors.black54,
                  Colors.black,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.0, 0.5, 0.8, 1.0],
              ),
            ),
            child: widget.child,
          );
        },
      ),
    );
  }
}
