// lib/data/audio_data.dart
import 'package:audio_service/audio_service.dart';

final List<MediaItem> audioList = [
  MediaItem(
    id: 'https://demo.unified-streaming.com/k8s/features/stable/video/tears-of-steel/tears-of-steel.ism/.m3u8',
    album: 'Sample Album',
    title: 'Sample Audio 1',
    artist: 'Artist 1',
    duration: const Duration(minutes: 3, seconds: 50),
    artUri: Uri.parse('https://i.imgur.com/JqG88zh.jpeg'),
  ),
  MediaItem(
    id: 'https://s3.amazonaws.com/scifri-segments/scifri201711241.mp3',
    album: "Science Friday",
    title: "From Cat Rheology To Operatic Incompetence",
    artist: "Science Friday and WNYC Studios",
    duration: const Duration(milliseconds: 2856950),
    artUri: Uri.parse('https://i.imgur.com/e57jBNP.jpeg'),
  ),
];

class MediaLibrary {
  static const albumsRootId = 'albums';

  final items = <String, List<MediaItem>>{
    AudioService.browsableRootId: const [
      MediaItem(
        id: albumsRootId,
        title: "Albums",
        playable: false,
      ),
    ],
    albumsRootId: audioList,
  };
}
