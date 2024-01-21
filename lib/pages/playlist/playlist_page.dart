import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundbox/core/models/playlist_model.dart';
import 'package:soundbox/core/models/popup_menu_options.dart';
import 'package:soundbox/providers/song_provider.dart';
import 'package:soundbox/widgets/song_tile.dart';
import 'package:soundbox/services/pocketbase_service.dart';

class PlaylistPage extends StatelessWidget {
  const PlaylistPage({super.key, required this.playlistId});
  final String playlistId;

  @override
  Widget build(BuildContext context) {
    SongProvider songProvider = Provider.of<SongProvider>(context);

    return FutureBuilder(
        future: PocketBaseService.instance.getPlaylist(playlistId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (!snapshot.hasData || snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(),
              body: const Center(
                child: Text("Cannot view playlist"),
              ),
            );
          }
          Playlist pl = snapshot.data!;

          List<PopUpMenuOption> options = [
            PopUpMenuOption(
                icon: const Icon(Icons.add),
                label: "Add Playlist to Queue",
                onTap: () => songProvider.addMultipleToQueue(pl.songs)),
            PopUpMenuOption(
                icon: const Icon(Icons.edit),
                label: "Edit Playlist",
                onTap: () {}),
          ];

          return Scaffold(
            appBar: AppBar(
                leading: const BackButton(),
                title: const Text("Playlist"),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: PopupMenuButton(itemBuilder: (context) {
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
                    }),
                  )
                ]),
            body: SafeArea(
              child: Container(
                width: 600,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          padding: const EdgeInsets.all(10),
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          child: const Center(
                            child: Icon(
                              Icons.star,
                              size: 40,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pl.name,
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                            Text(
                              "${pl.songs.length} songs",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: TextField(
                          decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        suffixIcon: IconButton(
                            onPressed: () {}, icon: const Icon(Icons.search)),
                        hintText: "Start typing to search",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0)),
                      )),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: pl.songs.length,
                          itemBuilder: (context, index) {
                            return SongTile(song: pl.songs[index]);
                          }),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
