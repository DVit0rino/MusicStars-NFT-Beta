import 'package:audio_testing_app/domain/playlists/playlist_item.dart';
import 'package:flutter/material.dart';
import 'commons/player_buttons_container.dart';
import 'commons/playlist_view.dart';

/// A screen with a playlist.
class PlaylistScreen extends StatelessWidget {
  final List<PlaylistItem> _playlist;

  PlaylistScreen(this._playlist, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SafeArea(
          child: PlayerButtonsContainer(
            child: PlaylistView(_playlist),
          ),
        ),
      ),
    );
  }
}
