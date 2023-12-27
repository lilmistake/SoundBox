import 'package:soundbox/core/models/album_model.dart';
import 'package:soundbox/core/models/song_download_model.dart';
import 'package:soundbox/core/models/song_image_model.dart';

class Song {
  String id;
  String name;
  String? type;
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
  int explicitContent;
  String playCount;
  String language;
  bool hasLyrics;
  String url;
  String? copyRight;
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
    this.type,
    this.releaseDate,
    this.featuredArtists,
    this.featuredArtistsId,
    this.copyRight,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
        id: json["id"],
        name: json["name"].toString().replaceAll("&amp;", "&"),
        album: Album.fromJson(json["album"]),
        year: json["year"],
        duration: int.parse(json["duration"]),
        label: json["label"],
        primaryArtists: json["primaryArtists"],
        primaryArtistsId: json["primaryArtistsId"],
        explicitContent: json["explicitContent"],
        playCount: json["playCount"],
        language: json["language"],
        hasLyrics: json["hasLyrics"] == 'true',
        url: json["url"],
        images: (json["image"] as List<dynamic>).map((e) => SongImage.fromJson(e)).toList(),
        downloadUrls: (json["downloadUrl"] as List<dynamic>).map((e) => SongDownloadUrl.fromJson(e)).toList(),
        type: json["type"],
        releaseDate: json["releaseDate"],
        featuredArtists: json["featuredArtists"],
        featuredArtistsId: json["featuredArtistsId"]);
  }
}
