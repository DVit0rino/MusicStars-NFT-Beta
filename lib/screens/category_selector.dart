import 'package:audio_testing_app/screens/playlist_screen.dart';
import 'package:audio_testing_app/services/playlists/playlist_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'commons/player_buttons_container.dart';
import 'package:audio_testing_app/styles/styles.dart';

/// A selector screen for categories of audio.
///
/// Current categories are:
///  - all items;
class CategorySelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Playlists", style: ThemeText.twentyEightBold),
      ),
      body: Center(
        child: SafeArea(
          child: PlayerButtonsContainer(
            child: Consumer<PlaylistsService>(
              builder: (__, value, _) {
                return Container(
                  color: ThemeColors.colorDarkGrey,
                  child: Column(
                    children: [
                      ListView(
                        shrinkWrap: true,
                        children: [
                          ListTile(
                            title: Text("All items",
                                style: ThemeText.eighteenBold),
                            tileColor: ThemeColors.colorBlackButtonBackground,
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      PlaylistScreen(value.allItems),
                                ),
                              );
                            },
                          ),
                        ]..addAll(
                            value.playlists.keys.map((playlistName) {
                              return ListTile(
                                title: Text(playlistName,
                                    style: ThemeText.eighteenBold),
                                tileColor:
                                    ThemeColors.colorBlackButtonBackground,
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => PlaylistScreen(
                                          value.playlists[playlistName]!),
                                    ),
                                  );
                                },
                              );
                            }),
                          ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
