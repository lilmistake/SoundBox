class Album {
  String id;
  String name;
  String url;

  Album({required this.id, required this.name, required this.url});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(id: json["id"], name: json["name"], url: json["url"]);
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "name": name, "url": url};
  }
}