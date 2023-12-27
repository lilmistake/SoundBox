class Lyrics {
  final String lyrics;
  final String copyright;

  Lyrics({required this.copyright, required this.lyrics});

  factory Lyrics.fromJson(Map<String, dynamic> json) {
    return Lyrics(
        copyright: json['data']['copyright'], lyrics: json['data']['lyrics']);
  }
  
}
