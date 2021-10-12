import 'package:audio_testing_app/domain/playlists/playlist_item.dart';
import 'package:audio_testing_app/services/audio_player_service.dart';
import 'package:audio_testing_app/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// A list of tiles showing all the items of a playlist.
///
/// Items are displayed with a `ListTile` with a leading image (the
/// artwork), and the title of the item.
class PlaylistView extends StatelessWidget {
  final List<PlaylistItem> _playlist;

  PlaylistView(this._playlist, {Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      color: ThemeColors.colorDarkGrey,
      child: ListView(
        children: [
          for (var i = 0; i < _playlist.length; i++)
            ListTile(
              // selected: i == state.currentIndex, // TODO only if this is the loaded playlist
              leading: Image.network(_playlist[i].artworkLocation),
              title: Text(_playlist[i].title, style: ThemeText.eighteenBold),
              tileColor: ThemeColors.colorBlackButtonBackground,
              onTap: () {
                final player =
                    Provider.of<AudioPlayerService>(context, listen: false);

                player
                    .loadPlaylist(_playlist)
                    .then((_) => player.seekToIndex(i))
                    .then((_) => player.play());
              },
            ),
        ],
      ),
    );
  }
}
