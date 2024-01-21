import 'package:soundbox/core/models/album_model.dart';
import 'package:soundbox/core/models/song_download_model.dart';
import 'package:soundbox/core/models/song_image_model.dart';

class Song {
  String id;
  String name;
  String? lyrics;
  Album album;
  String year;
  String? releaseDate;
  int duration;
  String label;
  String primaryArtists;
  String primaryArtistsId;
  String? featuredArtists;
  String? featuredArtistsId;
  bool explicitContent;
  String playCount;
  String language;
  bool hasLyrics;
  String url;
  List<SongImage> images;
  List<SongDownloadUrl> downloadUrls;

  Song({
    required this.id,
    required this.name,
    required this.album,
    required this.year,
    required this.duration,
    required this.label,
    required this.primaryArtists,
    required this.primaryArtistsId,
    required this.explicitContent,
    required this.playCount,
    required this.language,
    required this.hasLyrics,
    this.lyrics,
    required this.url,
    required this.images,
    required this.downloadUrls,
    this.releaseDate,
    this.featuredArtists,
    this.featuredArtistsId,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
        id: json["songId"] ?? json["id"],
        name: json["name"].toString().replaceAll("&amp;", "&"),
        album: Album.fromJson(json["album"]),
        images: (json["image"]as List<dynamic>)
            .map((e) => SongImage.fromJson(e))
            .toList(),
        year: json["year"].toString(),
        duration: int.parse(json["duration"].toString()),
        downloadUrls: (json["downloadUrl"] as List<dynamic>)
            .map((e) => SongDownloadUrl.fromJson(e))
            .toList(),
        label: json["label"].toString(),
        primaryArtists: json["primaryArtists"].toString(),
        primaryArtistsId: json["primaryArtistsId"].toString(),
        explicitContent: json["explicitContent"] == 1,
        playCount: json["playCount"].toString(),
        language: json["language"],
        hasLyrics: json["hasLyrics"] == 'true',
        url: json["url"],
        releaseDate: json["releaseDate"],
        featuredArtists: json["featuredArtists"],
        featuredArtistsId: json["featuredArtistsId"]);
  }

  toJson() {
    return {
      "songId": id,
      "name": name,
      "album": album.toJson(),
      "year": year,
      "duration": duration,
      "label": label,
      "primaryArtists": primaryArtists,
      "primaryArtistsId": primaryArtistsId,
      "explicitContent": explicitContent,
      "playCount": playCount,
      "language": language,
      "hasLyrics": hasLyrics,
      "url": url,
      "image": images.map((e) => e.toJson()).toList(),
      "downloadUrl": downloadUrls.map((e) => e.toJson()).toList(),
      "releaseDate": releaseDate,
      "featuredArtists": featuredArtists,
      "featuredArtistsId": featuredArtistsId,
    };
  }

  static Map<String, dynamic> databaseSchema() {
    return {
      'name': 'song',
      'type': 'base',
      'schema': [
        {
          'name': 'songId',
          'type': 'text',
          'required': true,
        },
        {
          'name': 'name',
          'type': 'text',
          'required': true,
        },
        {
          'name': 'album',
          'type': 'json',
          'required': true,
          "options": {"maxSize": 2000000}
        },
        {
          'name': 'year',
          'type': 'number',
          'required': true,
        },
        {
          'name': 'duration',
          'type': 'number',
          'required': true,
        },
        {
          'name': 'label',
          'type': 'text',
          'required': true,
        },
        {
          'name': 'primaryArtists',
          'type': 'text',
          'required': true,
        },
        {
          'name': 'primaryArtistsId',
          'type': 'text',
          'required': true,
        },
        {
          'name': 'explicitContent',
          'type': 'number',
          'required': true,
        },
        {
          'name': 'playCount',
          'type': 'text',
          'required': true,
        },
        {
          'name': 'language',
          'type': 'text',
          'required': true,
        },
        {
          'name': 'hasLyrics',
          'type': 'bool',
          'required': true,
        },
        {
          'name': 'url',
          'type': 'text',
          'required': true,
        },
        {
          'name': 'image',
          'type': 'json',
          'required': true,
        },
        {
          'name': 'downloadUrl',
          'type': 'json',
          'required': true,
          "options": {"maxSize": 2000000}
        },
        {
          'name': 'releaseDate',
          'type': 'text',
          'required': false,
        },
        {
          'name': 'featuredArtists',
          'type': 'text',
          'required': false,
        },
        {
          'name': 'featuredArtistsId',
          'type': 'text',
          'required': false,
        },
      ],
    };
  }
}
