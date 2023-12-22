import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:soundbox/models/song_model.dart';

class SaavnApiService {
  Future<List<Song>?> searchForSong(String query, {int limit = 5}) async {
    Uri uri = Uri(
        scheme: "https",
        host: "saavn.me",
        path: "search/songs",
        queryParameters: {
          "query": query,
          "page": "1",
          "limit": limit.toString()
        });

    var response = await http.get(uri);
    if (response.statusCode != 200 ||
        jsonDecode(response.body)['data']['total'] == null ||
        jsonDecode(response.body)['data']['total'] == 0) {
      return null;
    }
    List<Song> songs = [];
    for (var result in jsonDecode(response.body)['data']['results']) {
      songs.add(Song.fromJson(result));
    }
    return songs;
  }
}