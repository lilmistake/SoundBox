import 'package:soundbox/core/models/playlist_model.dart';

class User {
  final String id;
  final String username;
  final DateTime created;
  final DateTime updated;
  final List<Playlist> playlists;

  User(
      {required this.id,
      required this.created,
      required this.updated,
      required this.playlists,
      required this.username});

  User copyWith(
      {String? id,
      String? name,
      DateTime? created,
      DateTime? updated,
      List<Playlist>? playlists,
      String? username}) {
    return User(
      username: username ?? this.username,
      playlists: playlists ?? this.playlists,
      id: id ?? this.id,
      created: created ?? this.created,
      updated: updated ?? this.updated,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'created': created.toIso8601String(),
        'updated': updated.toIso8601String(),
        'playlists': playlists.map((e) => e.toJson()).toList()
      };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        username: json['username'],
        id: json['id'],
        created: DateTime.parse(json['created']),
        updated: DateTime.parse(json['updated']),
        playlists: json['expand']['playlists'] == null
            ? []
            : (json['expand']['playlists'] as List<dynamic>)
                .map<Playlist>((e) => Playlist.fromJson(e))
                .toList());
  }
}
