import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundbox/widgets/song_tile.dart';
import 'package:soundbox/providers/song_provider.dart';

class QueueList extends StatelessWidget {
  /// Simple list of all songs in the queue with unclickable children.
  const QueueList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    SongProvider songProvider = Provider.of<SongProvider>(context);
    if (songProvider.queue?.isEmpty ?? true) {
      return const Text(
        "Empty Queue",
        textAlign: TextAlign.center,
      );
    }

    return ListView.builder(
        shrinkWrap: true,
        itemCount: songProvider.queue?.length ?? 0,
        itemBuilder: (context, index) => _QueueChild(index: index));
  }
}

class _QueueChild extends StatelessWidget {
  const _QueueChild({required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    SongProvider songProvider = Provider.of<SongProvider>(context);

    if (index == songProvider.currentSongIndex) {
      return Container(
        color: Theme.of(context).colorScheme.surfaceVariant,
        child: SongTile(
            clickable: false, song: songProvider.queue!.elementAt(index)),
      );
    }
    return SongTile(
        clickable: false, song: songProvider.queue!.elementAt(index));
  }
}
