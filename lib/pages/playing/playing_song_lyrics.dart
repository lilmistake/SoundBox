import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundbox/core/providers/song_provider.dart';

class PlayingSongLyrics extends StatelessWidget {
  const PlayingSongLyrics({
    super.key,
  });

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
                future: songProvider.getLyrics(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  return Text(
                    songProvider.currentSong!.lyrics!,
                    style: Theme.of(context).textTheme.headlineMedium,
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
