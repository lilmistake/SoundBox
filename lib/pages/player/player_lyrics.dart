import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundbox/core/models/lyrics_model.dart';
import 'package:soundbox/providers/song_provider.dart';
import 'package:soundbox/services/saavn_api_service.dart';

class PlayerSongLyrics extends StatelessWidget {
  const PlayerSongLyrics({
    super.key,
  });

  Future<String> handleLyrics(SongProvider songProvider) async {
    if (songProvider.currentSong == null) return "";
    if (songProvider.currentSong!.lyrics != null) {
      return songProvider.currentSong!.lyrics!;
    }
    if (!songProvider.currentSong!.hasLyrics) {
      songProvider.setLyrics("No Lyrics Found", songProvider.currentSongIndex);
      return "No Lyrics Found";
    }

    SaavnApiService saavnApiService = SaavnApiService();
    Lyrics? lyrics =
        await saavnApiService.getLyrics(songProvider.currentSong!.id);
    if (lyrics == null) {
      songProvider.setLyrics("No Lyrics Found", songProvider.currentSongIndex);
      return "No Lyrics Found";
    }
    songProvider.setLyrics(lyrics.lyrics, songProvider.currentSongIndex);
    return lyrics.lyrics;
  }

  @override
  Widget build(BuildContext context) {
    final SongProvider songProvider = Provider.of<SongProvider>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.surfaceVariant),
            padding: const EdgeInsets.all(10),
            child: Center(
              child: FutureBuilder(
                future: handleLyrics(songProvider),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  return Text(
                    snapshot.data!,
                    style: Theme.of(context).textTheme.titleLarge,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
