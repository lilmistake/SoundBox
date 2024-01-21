import 'package:soundbox/core/data/consts.dart';
import 'package:soundbox/core/models/song_model.dart';

class Playlist {
  final String playlistId;
  final DateTime created;
  final DateTime updated;
  final int duration;
  final List<Song> songs;

  final String name;
  final String? imageUrl;
  final bool isFav;

  Playlist({
    required this.playlistId,
    required this.name,
    required this.isFav,
    required this.songs,
    required this.duration,
    required this.created,
    this.imageUrl = defaultPlaylistIcon,
    required this.updated,
  });

  Map<String, dynamic> toJson() => {
        'id': playlistId,
        'imageUrl': imageUrl,
        'created': created.toIso8601String(),
        'updated': updated.toIso8601String(),
        'duration': songs.fold(0, (a, b) => a + b.duration),
        'songs': songs.map((e) => e.toJson()).toList(),
        'name': name,
        'isFav': isFav
      };

  factory Playlist.fromJson(Map<String, dynamic> json) {
    return Playlist(
      playlistId: json['id'],
      imageUrl: json['imageUrl'] ?? defaultPlaylistIcon,
      created: DateTime.parse(json['created']),
      updated: DateTime.parse(json['updated']),
      name: json['name'],
      isFav: json['isFav'],
      songs: json['expand']['songs'] == null
          ? []
          : (json['expand']['songs'] as List<dynamic>)
              .map<Song>((e) => Song.fromJson(e))
              .toList(),
      duration: json['duration'],
    );
  }

  Playlist copyWith(
      {String? userId,
      String? playlistId,
      String? name,
      String? imageUrl,
      int? creationTs,
      bool? isFav,
      int? lastUpdateTs,
      List<Song>? songs,
      int? duration}) {
    return Playlist(
      playlistId: playlistId ?? this.playlistId,
      imageUrl: imageUrl ?? this.imageUrl,
      name: name ?? this.name,
      isFav: isFav ?? this.isFav,
      songs: songs ?? this.songs,
      duration: duration ?? this.duration,
      created: created,
      updated: updated,
    );
  }
}
