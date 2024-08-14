// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:audio_service/audio_service.dart';
import 'package:get_it/get_it.dart';

import 'presentation/bloc/audio_bloc.dart';
import 'presentation/view/audio_list_screen.dart';
import 'services/audio_player_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final audioHandler = await AudioService.init(
    builder: () => AudioPlayerHandler(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'com.example.app.channel.audio',
      androidNotificationChannelName: 'Audio playback',
      androidNotificationOngoing: true,
    ),
  );

  GetIt.I.registerSingleton<AudioHandler>(audioHandler);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AudioBloc(),
      child: MaterialApp(
        title: 'Audio Player App',
        theme: ThemeData.dark(),
        home: AudioListScreen(),
      ),
    );
  }
}
