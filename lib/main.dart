import 'package:audio_testing_app/screens/category_selector.dart';
import 'package:audio_testing_app/screens/just_audio_player.dart';
import 'package:audio_testing_app/services/audio_player_service.dart';
import 'package:audio_testing_app/services/playlists/hardcoded_playlists_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/playlists/playlist_service.dart';
import 'package:audio_testing_app/styles/styles.dart';
import 'package:audio_testing_app/screens/audio_player_streaming.dart';

//Command to run: flutter run -d chrome --web-renderer html

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<PlaylistsService>(
          create: (_) => HardcodedPlaylistsService(),
        ),
        Provider<AudioPlayerService>(
          create: (_) => AudioPlayerStreaming(),
          dispose: (_, value) {
            (value as AudioPlayerStreaming).dispose();
          },
        ),
      ],
      child: MaterialApp(
        title: "Web Player App Test - MusicStars Alpha's Alpha",
        debugShowCheckedModeBanner: false,
        home: CategorySelector(),
        theme: ThemeData(
          primaryColor: ThemeColors.colorBlack,
          textTheme: const TextTheme(
              headline1: ThemeText.twentyEightBold,
              bodyText1: ThemeText.regularFifteen),
        ),
      ),
    );
  }
}
