import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundbox/core/models/popup_menu_options.dart';
import 'package:soundbox/core/models/song_model.dart';
import 'package:soundbox/providers/song_provider.dart';

class SongTile extends StatelessWidget {
  const SongTile({super.key, required this.song, this.clickable = true});
  final Song song;
  final bool clickable;

  row() {
    if (song.explicitContent) {
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

    List<PopUpMenuOption> options = [
      PopUpMenuOption(
          icon: const Icon(Icons.play_arrow_rounded),
          label: "Play Song",
          onTap: () {
            songProvider.setCurrentSong(song);
          }),
      PopUpMenuOption(
          icon: const Icon(Icons.queue_play_next),
          label: "Play Next",
          onTap: () {
            songProvider.playSongNext(song);
          }),
      PopUpMenuOption(
          icon: const Icon(Icons.add),
          label: "Add to Queue",
          onTap: () {
            songProvider.addToQueue(song);
          }),
      PopUpMenuOption(
          icon: const Icon(Icons.playlist_add),
          label: "Add to Playlist",
          onTap: () {}),
      PopUpMenuOption(
          icon: const Icon(Icons.star_rounded),
          label: "Add to Favourites",
          onTap: () {}),
      PopUpMenuOption(
          icon: const Icon(Icons.person), label: "View Artist", onTap: () {}),
    ];
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
        trailing: PopupMenuButton(itemBuilder: (context) {
          return options
              .map((e) => PopupMenuItem(
                    value: e,
                    onTap: () => e.onTap(),
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
