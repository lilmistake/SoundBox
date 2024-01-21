import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundbox/core/data/breakpoints.dart';
import 'package:soundbox/core/extensions/with_gap_y.dart';
import 'package:soundbox/providers/song_provider.dart';
import 'package:soundbox/services/pocketbase_service.dart';
import 'package:soundbox/widgets/queue_list.dart';

class HomeQueueSection extends StatelessWidget {
  const HomeQueueSection({super.key});

  @override
  Widget build(BuildContext context) {
    SongProvider songProvider = Provider.of<SongProvider>(context);

    if ((songProvider.queue?.isNotEmpty ?? false) &&
        showPermanentQueue(context)) {
      return Expanded(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              songProvider.queue!.forEach((element) {
                                PocketBaseService.instance.createSong(element);
                              });
                            },
                            icon: const Icon(Icons.check)),
                        Text("My Queue",
                            style: Theme.of(context).textTheme.titleLarge),
                      ],
                    ),
                    const QueueList()
                  ].withGapY(height: 10),
                ),
              ),
            ),
            const VerticalDivider()
          ],
        ),
      );
    }
    return const SizedBox();
  }
}
