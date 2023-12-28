import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundbox/pages/playing/playing_page.dart';
import 'package:soundbox/core/providers/song_provider.dart';

class SongControleBar extends StatelessWidget {
  const SongControleBar({super.key, required this.setDrawer});
  final Function(Widget) setDrawer;

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
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                color: Theme.of(context).colorScheme.surfaceVariant),
            child: ListTile(
              onTap: () {
                setDrawer(const PlayingPage());
                Scaffold.of(context).openDrawer();
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
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(5)),
                        color: Theme.of(context).colorScheme.onBackground),
                    child: const SizedBox(),
                  ),
                ),
                Expanded(
                  flex: 100000 - progress,
                  child: Container(
                    height: 5,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(5)),
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
