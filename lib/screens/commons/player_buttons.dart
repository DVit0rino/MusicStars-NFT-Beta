//This widget will use streams to handle the state; It is therefore stateless
import 'package:audio_testing_app/domain/playlists/playlist_item.dart';
import 'package:audio_testing_app/services/audio_player_service.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:audio_testing_app/styles/styles.dart';

import '../audio_player_streaming.dart';

/// A `Row` of buttons that interact with audio.
///
/// The order is: shuffle, previous, play/pause/restart, next, repeat.
class PlayerButtons extends StatelessWidget {
  late final AudioPlayerStreaming streamingAudio = AudioPlayerStreaming();

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioPlayerService>(builder: (_, player, __) {
      return Column(
        children: [
          ValueListenableBuilder<ProgressBarState>(
            valueListenable: streamingAudio.progressNotifier,
            builder: (_, value, __) {
              return ProgressBar(
                progress: value.current,
                buffered: value.buffered,
                total: value.total,
                onSeek: streamingAudio.seek,
                progressBarColor: ThemeColors.colorYellowBrand,
                baseBarColor: ThemeColors.colorWhite.withOpacity(0.24),
                bufferedBarColor: ThemeColors.colorWhite.withOpacity(0.24),
                thumbColor: ThemeColors.colorYellowButtonPressed,
                barHeight: 3.0,
                thumbRadius: 5.0,
                timeLabelLocation: TimeLabelLocation.sides,
              );
            },
          ),
          Container(
            color: ThemeColors.colorBlack,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Shuffle
                StreamBuilder<bool>(
                  stream: player.shuffleModeEnabled,
                  builder: (context, snapshot) {
                    return _shuffleButton(
                        context, snapshot.data ?? false, player);
                  },
                ),
                // Previous
                StreamBuilder<List<PlaylistItem>?>(
                  stream: player.currentPlaylist,
                  builder: (_, __) {
                    return _previousButton(player);
                  },
                ),
                // Play/pause/restart
                StreamBuilder<AudioProcessingState>(
                  stream: player.audioProcessingState,
                  builder: (_, snapshot) {
                    final playerState =
                        snapshot.data ?? AudioProcessingState.unknown;
                    return _playPauseButton(playerState, player);
                  },
                ),
                // Next
                StreamBuilder<List<PlaylistItem>?>(
                  stream: player.currentPlaylist,
                  builder: (_, __) {
                    return _nextButton(player);
                  },
                ),
                // Repeat
                StreamBuilder<PlaylistLoopMode>(
                  stream: player.loopMode,
                  builder: (context, snapshot) {
                    return _repeatButton(
                        context, snapshot.data ?? PlaylistLoopMode.off, player);
                  },
                ),
              ],
            ),
          ),
        ],
      );
    });
  }

  /// A button that plays or pauses the audio.
  ///
  /// If the audio is playing, a pause button is shown.
  /// If the audio has finished playing, a restart button is shown.
  /// If the audio is paused, or not started yet, a play button is shown.
  /// If the audio is loading, a progress indicator is shown.
  Widget _playPauseButton(
      AudioProcessingState processingState, AudioPlayerService player) {
    if (processingState == AudioProcessingState.loading ||
        processingState == AudioProcessingState.buffering) {
      return Container(
        margin: EdgeInsets.all(8.0),
        width: 64.0,
        height: 64.0,
        child: CircularProgressIndicator(),
      );
    } else if (processingState == AudioProcessingState.ready) {
      return IconButton(
        icon: Icon(Icons.play_arrow, color: ThemeColors.colorWhite),
        iconSize: 64.0,
        onPressed: player.play,
      );
    } else if (processingState != AudioProcessingState.completed) {
      return IconButton(
        icon: Icon(Icons.pause, color: ThemeColors.colorWhite),
        iconSize: 64.0,
        onPressed: player.pause,
      );
    } else {
      return IconButton(
        icon: Icon(Icons.replay, color: ThemeColors.colorWhite),
        iconSize: 64.0,
        onPressed: () => player.seekToStart(),
      );
    }
  }

  /// A shuffle button. Tapping it will either enabled or disable shuffle mode.
  Widget _shuffleButton(
      BuildContext context, bool isEnabled, AudioPlayerService player) {
    return IconButton(
      icon: isEnabled
          ? Icon(Icons.shuffle, color: ThemeColors.colorYellowBrand) //on
          : Icon(Icons.shuffle, color: ThemeColors.colorWhite), //off
      onPressed: () async {
        final enable = !isEnabled;
        await player.setShuffleModeEnabled(enable);
      },
    );
  }

  /// A previous button. Tapping it will seek to the previous audio in the list.
  Widget _previousButton(AudioPlayerService player) {
    return IconButton(
      icon: Icon(Icons.skip_previous,
          color: player.hasPrevious
              ? ThemeColors.colorWhite
              : ThemeColors.colorDarkGrey),
      onPressed: player.hasPrevious ? player.seekToPrevious : null,
    );
  }

  /// A next button. Tapping it will seek to the next audio in the list.
  Widget _nextButton(AudioPlayerService player) {
    return IconButton(
      icon: Icon(Icons.skip_next,
          color: player.hasNext
              ? ThemeColors.colorWhite
              : ThemeColors.colorDarkGrey),
      onPressed: player.hasNext ? player.seekToNext : null,
    );
  }

  /// A repeat button. Tapping it will cycle through not repeating, repeating
  /// the entire list, or repeat the current audio.
  Widget _repeatButton(BuildContext context, PlaylistLoopMode loopMode,
      AudioPlayerService player) {
    final icons = [
      Icon(Icons.repeat, color: ThemeColors.colorWhite), //off
      Icon(Icons.repeat, color: ThemeColors.colorYellowBrand), //on, all songs
      Icon(Icons.repeat_one,
          color: ThemeColors.colorYellowBrand), //on, one song
    ];
    const cycleModes = [
      PlaylistLoopMode.off,
      PlaylistLoopMode.all,
      PlaylistLoopMode.one,
    ];
    final index = cycleModes.indexOf(loopMode);
    return IconButton(
      icon: icons[index],
      onPressed: () {
        player.setLoopMode(
            cycleModes[(cycleModes.indexOf(loopMode) + 1) % cycleModes.length]);
      },
    );
  }
}
