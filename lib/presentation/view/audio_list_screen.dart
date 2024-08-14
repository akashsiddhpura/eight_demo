import 'package:eight_demo/data/audio_data.dart';
import 'package:eight_demo/presentation/bloc/audio_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'audio_player_screen.dart';

class AudioListScreen extends StatelessWidget {
  const AudioListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio List'),
      ),
      body: ListView.builder(
        itemCount: audioList.length,
        itemBuilder: (context, index) {
          final item = audioList[index];
          return ListTile(
            title: Text(item.title),
            subtitle: Text(item.artist ?? ''),
            onTap: () {
              context.read<AudioBloc>().add(LoadPlaylistEvent(audioList, index: index));
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AudioPlayerScreen(),
              ));
            },
          );
        },
      ),
    );
  }
}
