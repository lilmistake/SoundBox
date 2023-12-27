import 'package:flutter/material.dart';
import 'package:soundbox/core/models/song_model.dart';
import 'package:soundbox/services/saavn_api_service.dart';
import 'package:soundbox/pages/search/search_result_tile.dart';

class SearchResultDrawer extends StatelessWidget {
  const SearchResultDrawer({super.key, required this.query});
  final String query;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: double.infinity,
        child: Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Showing Results for',
                    ),
                    Text(
                      '"$query"',
                      style: Theme.of(context).textTheme.headlineMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const CloseButton()
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(child: _SearchResults(query: query)),
        ],
      ),
    ));
  }
}

class _SearchResults extends StatelessWidget {
  const _SearchResults({required this.query});
  final String query;
  @override
  Widget build(BuildContext context) {
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
