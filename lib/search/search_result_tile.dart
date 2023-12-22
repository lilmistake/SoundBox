import 'package:flutter/material.dart';
import 'package:soundbox/models/song_model.dart';

class SearchResultTile extends StatelessWidget {
  const SearchResultTile({super.key, required this.song});
  final Song song;

  row() {
    if (song.explicitContent == 1) {
      return Row(
        children: [
          const Icon(
            Icons.explicit,
            size: 15,
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
              child: Text(song.primaryArtists,
                  overflow: TextOverflow.ellipsis)),
        ],
      );
    }
    return Text(song.primaryArtists, overflow: TextOverflow.ellipsis);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      title: Text(
        song.name,
        style: const TextStyle(fontSize: 15),
        maxLines: 1,
      ),
      subtitle: row(),
      leading: Image.network(song.images.first.link, fit: BoxFit.cover),
      contentPadding: const EdgeInsets.symmetric(horizontal: 5),
      trailing: IconButton(
          icon: const Icon(Icons.more_vert_sharp),
          onPressed: () {},
          padding: const EdgeInsets.all(0),
          constraints: const BoxConstraints()),
    );
  }
}