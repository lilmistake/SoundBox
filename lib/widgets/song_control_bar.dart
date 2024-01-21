import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundbox/pages/player/player_page.dart';
import 'package:soundbox/providers/song_provider.dart';


class SongControlBar extends StatelessWidget {
  /// Floating Song Control Bar at the bottom of the page.
  /// Allows to pause, resume, play previous, play next song.
  /// Also displays a progress bar based from a Duration Stream.
  const SongControlBar({super.key, required this.setEndDrawer});
  final Function(Widget) setEndDrawer;

  @override
  Widget build(BuildContext context) {
    SongProvider songProvider = Provider.of<SongProvider>(context);
    if (songProvider.currentSong == null) {
      return Container();
    }
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        _ProgressBar(songProvider: songProvider),
        Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: const BorderRadius.only(),
                color: Theme.of(context).colorScheme.surfaceVariant),
            child: ListTile(
              onTap: () {
                setEndDrawer(const PlayerPage());
                Scaffold.of(context).openEndDrawer();
              },
              minVerticalPadding: 0,
              dense: true,
              title: Text(
                songProvider.currentSong!.name,
                style: const TextStyle(fontSize: 15),
                maxLines: 1,
              ),
              subtitle: Text(songProvider.currentSong?.primaryArtists ?? '',
                  overflow: TextOverflow.ellipsis),
              leading: songProvider.currentSong?.images.first.link != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                          songProvider.currentSong?.images.first.link ?? '',
                          fit: BoxFit.cover),
                    )
                  : null,
              contentPadding: const EdgeInsets.symmetric(horizontal: 5),
              trailing: Wrap(
                children: [
                  IconButton(
                      icon: const Icon(Icons.skip_previous),
                      onPressed: () {
                        songProvider.playPrevious();
                      }),
                  IconButton(
                      icon: Icon(songProvider.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow),
                      onPressed: songProvider.handlePausePlay),
                  IconButton(
                      icon: const Icon(Icons.skip_next),
                      onPressed: () {
                        songProvider.playNext();
                      }),
                ],
              ),
            )),
      ],
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({
    required this.songProvider,
  });

  final SongProvider songProvider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: StreamBuilder(
          stream: songProvider.positionStream(),
          builder: (context, snapshot) {
            int millisecondsPassed = snapshot.data?.inMilliseconds ?? 0;
            int songDuration = (songProvider.currentSong?.duration ?? 1) * 1000;
            int progress =
                ((millisecondsPassed * 100000 / songDuration)).ceil();
            return Row(
              children: [
                Expanded(
                  flex: progress,
                  child: Container(
                    height: 5,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onBackground),
                    child: const SizedBox(),
                  ),
                ),
                Expanded(
                  flex: 100000 - progress,
                  child: Container(
                    height: 5,
                    decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(0.5)),
                    child: const SizedBox(),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
