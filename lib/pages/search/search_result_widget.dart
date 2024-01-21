import 'package:flutter/material.dart';
import 'package:soundbox/core/models/song_model.dart';
import 'package:soundbox/services/saavn_api_service.dart';
import 'package:soundbox/widgets/song_tile.dart';

class SearchResult extends StatelessWidget {
  const SearchResult({super.key, required this.query});
  final String query;
  @override
  Widget build(BuildContext context) {
    if (query.isEmpty) return Container();
    return FutureBuilder(
        future: SaavnApiService().searchForSong(query, limit: 25),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    Song? song = snapshot.data?[index];
                    if (song == null) {
                      return Container();
                    }
                    return SongTile(song: song);
                  });
            } else {
              return const Center(
                child: Text("No results found"),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
