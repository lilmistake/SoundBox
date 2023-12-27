import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundbox/core/extensions/with_gap_y.dart';
import 'package:soundbox/pages/playing/playing_progress_bar.dart';
import 'package:soundbox/pages/playing/playing_song_controls.dart';
import 'package:soundbox/pages/playing/playing_song_lyrics.dart';
import 'package:soundbox/core/providers/song_provider.dart';

class PlayingPage extends StatelessWidget {
  const PlayingPage({super.key});

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
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        songProvider.currentSong!.images.last.link,
                      ),
                    ),
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
                            style: Theme.of(context).textTheme.headlineMedium,
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
                const PlayingProgressBar(),
                const PlayingSongControls(),
                const PlayingSongLyrics()
              ].withGapY(height: 10),
            ),
          ),
        ),
      ),
    );
  }
}