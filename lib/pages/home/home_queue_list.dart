import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundbox/pages/search/search_result_tile.dart';
import 'package:soundbox/core/providers/song_provider.dart';

class HomeQueueList extends StatelessWidget {
  const HomeQueueList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    SongProvider songProvider = Provider.of<SongProvider>(context);
    if (songProvider.currentQueue?.isEmpty ?? true) {
      return const SizedBox();
    }
    return ListView.builder(
        itemCount: songProvider.currentQueue?.length ?? 0,
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
        child: SearchResultTile(
            clickable: false,
            song: songProvider.currentQueue!.elementAt(index)),
      );
    }
    return SearchResultTile(
        clickable: false, song: songProvider.currentQueue!.elementAt(index));
  }
}
