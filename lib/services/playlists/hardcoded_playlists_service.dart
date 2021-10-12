//Hardcoded for purposes of testing

import '/domain/playlists/author.dart';
import '/domain/playlists/playlist_item.dart';
import '/services/playlists/playlist_service.dart';

class HardcodedPlaylistsService implements PlaylistsService {
  final _gameSongs = [
    PlaylistItem(
        author: Author("Blizzard North", null),
        title: "Tristram",
        artworkLocation:
            "https://upload.wikimedia.org/wikipedia/en/3/3a/Diablo_Coverart.png",
        itemLocation: Uri.parse(
            "https://archive.org/download/IGM-V7/IGM%20-%20Vol.%207/25%20Diablo%20-%20Tristram%20%28Blizzard%29.mp3")),
    PlaylistItem(
        author: Author("Game Freak", null),
        title: "Cerulean City",
        artworkLocation:
            "https://upload.wikimedia.org/wikipedia/en/f/f1/Bulbasaur_pokemon_red.png",
        itemLocation: Uri.parse(
            "https://archive.org/download/igm-v8_202101/IGM%20-%20Vol.%208/15%20Pokemon%20Red%20-%20Cerulean%20City%20%28Game%20Freak%29.mp3")),
    PlaylistItem(
        author: Author("Lucasfilm Games", null),
        title: "The secret of Monkey Island - Introduction",
        artworkLocation:
            "https://upload.wikimedia.org/wikipedia/en/a/a8/The_Secret_of_Monkey_Island_artwork.jpg",
        itemLocation: Uri.parse(
            "https://scummbar.com/mi2/MI1-CD/01%20-%20Opening%20Themes%20-%20Introduction.mp3")),
  ];

  final _inessential = [
    PlaylistItem(
        author: Author("Brent Simmons", null),
        title: "Slow House",
        itemLocation: Uri.parse("asset:///assets/audio/SlowHouse.mp3")),
    PlaylistItem(
        author: Author("Brent Simmons", null),
        title: "Vampire’s Run",
        itemLocation: Uri.parse("asset:///assets/audio/VampiresRun.mp3")),
    PlaylistItem(
        author: Author("Brent Simmons", null),
        title: "Tie & Suit",
        itemLocation: Uri.parse("asset:///assets/audio/TieSuit2021.mp3")),
  ];

  @override
  List<PlaylistItem> get allItems {
    var allItemsList = [_gameSongs, _inessential].expand((x) => x).toList();

    return allItemsList;
  }

  @override
  Map<String, List<PlaylistItem>> get playlists {
    return {'Games': _gameSongs, "Inessential": _inessential};
  }

  @override
  // TODO: implement itemsByAuthor
  Map<Author, List<PlaylistItem>> get itemsByAuthor {
    throw UnimplementedError();
  }
}
