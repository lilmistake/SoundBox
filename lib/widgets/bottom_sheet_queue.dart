import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundbox/core/extensions/with_gap_x.dart';
import 'package:soundbox/providers/song_provider.dart';
import 'package:soundbox/widgets/queue_list.dart';

class BottomSheetQueue extends StatelessWidget {
  const BottomSheetQueue({super.key});

  @override
  Widget build(BuildContext context) {
    SongProvider songProvider = Provider.of<SongProvider>(context);
    return Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            border: Border.fromBorderSide(
                BorderSide(color: Theme.of(context).colorScheme.onBackground))),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                const CloseButton(),
                const Text(
                  "Queue",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  "(${songProvider.currentSongIndex + 1}/${songProvider.queue?.length})",
                ),
              ].withGapX(width: 5),
            ),
            const SizedBox(
              height: 10,
            ),
            const Expanded(child: QueueList()),
          ],
        ));
  }
}
