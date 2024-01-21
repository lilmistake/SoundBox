import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundbox/core/extensions/with_gap_y.dart';
import 'package:soundbox/pages/player/player_progress_bar.dart';
import 'package:soundbox/pages/player/player_controls.dart';
import 'package:soundbox/pages/player/player_lyrics.dart';
import 'package:soundbox/providers/song_provider.dart';

class PlayerPage extends StatelessWidget {
  const PlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    SongProvider songProvider = Provider.of<SongProvider>(context);
    if (songProvider.currentSong == null) {
      return const Center(
        child: Text("No Song in Queue"),
      );
    }
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const BackButton(),
                    Text(
                      "Now Playing",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.more_vert))
                  ],
                ),
                Center(
                  child: Image.network(
                    songProvider.currentSong!.images.last.link,
                    width: 300,
                    height: 300,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            songProvider.currentSong!.name,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(songProvider.currentSong!.primaryArtists),
                        ],
                      ),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.star_outline_rounded,
                          size: 30,
                        ))
                  ],
                ),
                const PlayerProgressBar(),
                const PlayerControls(),
                const PlayerSongLyrics()
              ].withGapY(height: 10),
            ),
          ),
        ),
      ),
    );
  }
}
