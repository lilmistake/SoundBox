import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundbox/core/models/song_model.dart';
import 'package:soundbox/core/providers/song_provider.dart';

class PopUpMenuOption {
  final Icon icon;
  final String label;
  final Function(SongProvider, Song) onTap;

  PopUpMenuOption(
      {required this.icon, required this.label, required this.onTap});
}

List<PopUpMenuOption> options = [
  PopUpMenuOption(
      icon: const Icon(Icons.add),
      label: "Add to Queue",
      onTap: (songProvider, song) {
        songProvider.addToQueue(song);
      }),
  PopUpMenuOption(
      icon: const Icon(Icons.play_arrow_rounded),
      label: "Play Song",
      onTap: (songProvider, song) {
        songProvider.setCurrentSong(song);
      }),
  /* PopUpMenuOption(
      icon: const Icon(Icons.person),
      label: "View Artist",
      onTap: (songProvider, song) {}),
  PopUpMenuOption(
      icon: const Icon(Icons.star_rounded),
      label: "Add to Favourites",
      onTap: (songProvider, song) {}), */
];

class SearchResultTile extends StatelessWidget {
  const SearchResultTile(
      {super.key, required this.song, this.clickable = true});
  final Song song;
  final bool clickable;

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
              child:
                  Text(song.primaryArtists, overflow: TextOverflow.ellipsis)),
        ],
      );
    }
    return Text(song.primaryArtists, overflow: TextOverflow.ellipsis);
  }

  @override
  Widget build(BuildContext context) {
    SongProvider songProvider = Provider.of<SongProvider>(context);
    return ListTile(
        onTap: () async {
          if (!clickable) return;
          Navigator.pop(context);
          songProvider.setCurrentSong(song);
        },
        dense: true,
        title: Text(
          song.name,
          style: const TextStyle(fontSize: 15),
          maxLines: 1,
        ),
        subtitle: row(),
        leading: Image.network(song.images.first.link),
        contentPadding: const EdgeInsets.symmetric(horizontal: 5),
        trailing: PopupMenuButton(onSelected: (value) {
          options
              .where((element) => element == value)
              .first
              .onTap(songProvider, song);
        }, itemBuilder: (context) {
          return options
              .map((e) => PopupMenuItem(
                    value: e,
                    child: Wrap(
                      children: [
                        e.icon,
                        const SizedBox(
                          width: 10,
                        ),
                        Text(e.label)
                      ],
                    ),
                  ))
              .toList();
        }));
  }
}
