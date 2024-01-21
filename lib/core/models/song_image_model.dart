class SongImage {
  String quality;
  String link;
  SongImage({required this.quality, required this.link});

  factory SongImage.fromJson(Map<String, dynamic> json) {
    return SongImage(quality: json["quality"], link: json["link"]);
  }

  Map<String, dynamic> toJson() {
    return {"quality": quality, "link": link};
  }
}
