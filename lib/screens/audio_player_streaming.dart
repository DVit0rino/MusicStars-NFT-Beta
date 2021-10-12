import 'package:audio_testing_app/domain/playlists/playlist_item.dart';
import 'package:audio_testing_app/services/audio_player_service.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class ProgressBarState {
  ProgressBarState({
    required this.current,
    required this.buffered,
    required this.total,
  });
  final Duration current;
  final Duration buffered;
  final Duration total;
}

enum ButtonState { paused, playing, loading }

class AudioPlayerStreaming implements AudioPlayerService {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final progressNotifier = ValueNotifier<ProgressBarState>(
    ProgressBarState(
        current: Duration.zero, buffered: Duration.zero, total: Duration.zero),
  );
  final buttonNotifier = ValueNotifier<ButtonState>(ButtonState.paused);

  //URL de streaming para receber a música
  static const urlDefaultSong =
      'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3';

  AudioPlayerStreaming() {
    _init();
  }

  void _init() async {
    await _audioPlayer.setUrl(urlDefaultSong);

    //listen for changes in player state
    _audioPlayer.playerStateStream.listen((playerState) {
      final isPlaying = playerState.playing;
      final processingState = playerState.processingState;

      if (processingState == ProcessingState.loading ||
          processingState == ProcessingState.buffering) {
        buttonNotifier.value = ButtonState.loading;
      } else if (!isPlaying) {
        buttonNotifier.value = ButtonState.paused;
      } else if (processingState != ProcessingState.completed) {
        buttonNotifier.value = ButtonState.playing;
      } else {
        _audioPlayer.seek(Duration.zero);
        _audioPlayer.pause();
      }
    });

    // listen for changes in play position
    _audioPlayer.positionStream.listen((position) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: position,
        buffered: oldState.buffered,
        total: oldState.total,
      );
    });

    // listen for changes in the buffered position
    _audioPlayer.bufferedPositionStream.listen((bufferedPosition) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: bufferedPosition,
        total: oldState.total,
      );
    });

    // listen for changes in the total audio duration
    _audioPlayer.durationStream.listen((totalDuration) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: oldState.buffered,
        total: totalDuration ?? Duration.zero,
      );
    });
  }

  // State
  @override
  Stream<AudioProcessingState> get audioProcessingState =>
      _audioPlayer.playerStateStream.map(
        (_playerStateMap),
      );

  @override
  Stream<List<PlaylistItem>?> get currentPlaylist =>
      _audioPlayer.sequenceStateStream.map(
        (sequenceState) {
          return sequenceState?.sequence
              .map(
                (source) => source.tag,
              )
              .whereType<PlaylistItem>()
              .toList();
        },
      );

  @override
  bool get hasNext => _audioPlayer.hasNext;

  @override
  bool get hasPrevious => _audioPlayer.hasPrevious;

  @override
  Stream<bool> get isPlaying => _audioPlayer.playingStream;

  @override
  Stream<PlaylistLoopMode> get loopMode =>
      _audioPlayer.loopModeStream.map((_loopModeMap));

  @override
  Stream<bool> get shuffleModeEnabled => _audioPlayer.shuffleModeEnabledStream;

  // Actions

  @override
  Future<void> pause() {
    return _audioPlayer.pause();
  }

  @override
  Future<void> play() async {
    return _audioPlayer.play();
  }

  void seek(Duration position) {
    _audioPlayer.seek(position);
  }

  @override
  Future<void> seekToNext() {
    return _audioPlayer.seekToNext();
  }

  @override
  Future<void> seekToPrevious() {
    return _audioPlayer.seekToPrevious();
  }

  @override
  Future<void> setLoopMode(PlaylistLoopMode mode) {
    switch (mode) {
      case PlaylistLoopMode.off:
        return _audioPlayer.setLoopMode(LoopMode.off);
      case PlaylistLoopMode.one:
        return _audioPlayer.setLoopMode(LoopMode.one);
      case PlaylistLoopMode.all:
        return _audioPlayer.setLoopMode(LoopMode.all);
    }
  }

  @override
  Future<void> setShuffleModeEnabled(bool enabled) async {
    if (enabled) {
      await _audioPlayer.shuffle();
    }
    return _audioPlayer.setShuffleModeEnabled(enabled);
  }

  @override
  Future<void> seekToStart() {
    return _audioPlayer.seek(Duration.zero,
        index: _audioPlayer.effectiveIndices?.first);
  }

  @override
  Future<void> seekToIndex(int index) {
    return _audioPlayer.seek(Duration.zero, index: index);
  }

  @override
  Future<Duration?> loadPlaylist(List<PlaylistItem> playlist) {
    // TODO do not load a playlist if it is already loaded.
    return _audioPlayer
        .setAudioSource(
      ConcatenatingAudioSource(
        children: playlist
            .map(
              (item) => AudioSource.uri(
                item.itemLocation,
                tag: item,
              ),
            )
            .toList(),
      ),
    )
        .catchError((error) {
      // catch load errors: 404, invalid url ...
      print("An error occured $error");
    });
  }

  Future<void> dispose() {
    return _audioPlayer.dispose();
  }

  // Helpers

  static AudioProcessingState _playerStateMap(PlayerState? state) {
    final processingState = state?.processingState;
    if (processingState == null) return AudioProcessingState.unknown;
    switch (processingState) {
      case ProcessingState.idle:
        return AudioProcessingState.idle;
      case ProcessingState.loading:
        return AudioProcessingState.loading;
      case ProcessingState.buffering:
        return AudioProcessingState.buffering;
      case ProcessingState.ready:
        if (state?.playing ?? false)
          return AudioProcessingState.playing;
        else
          return AudioProcessingState.ready;
      case ProcessingState.completed:
        return AudioProcessingState.completed;
    }
  }

  static PlaylistLoopMode _loopModeMap(LoopMode mode) {
    switch (mode) {
      case LoopMode.off:
        return PlaylistLoopMode.off;
      case LoopMode.one:
        return PlaylistLoopMode.one;
      case LoopMode.all:
        return PlaylistLoopMode.all;
    }
  }
}
