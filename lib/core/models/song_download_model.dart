class SongDownloadUrl {
  String quality;
  String link;

  SongDownloadUrl({required this.quality, required this.link});

  factory SongDownloadUrl.fromJson(Map<String, dynamic> json) {
    return SongDownloadUrl(quality: json["quality"], link: json["link"]);
  }
}
