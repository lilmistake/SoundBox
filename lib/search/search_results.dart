import 'package:flutter/material.dart';
import 'package:soundbox/models/song_model.dart';
import 'package:soundbox/services/saavn_api_service.dart';
import 'package:soundbox/search/search_result_tile.dart';

class SearchResultsDrawer extends StatelessWidget {
  const SearchResultsDrawer({super.key, required this.query});
  final String query;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Showing Results for',
                  ),
                  Text(
                    '"$query"',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
              const CloseButton()
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(child: SearchResults(query: query)),
        ],
      ),
    ));
  }
}

class SearchResults extends StatelessWidget {
  const SearchResults({super.key, required this.query});
  final String query;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: SaavnApiService().searchForSong(query, limit: 10),
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
                    return SearchResultTile(song: song);
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
