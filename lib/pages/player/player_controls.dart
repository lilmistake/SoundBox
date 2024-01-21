import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundbox/providers/song_provider.dart';

class PlayerControls extends StatelessWidget {
  const PlayerControls({super.key});

  @override
  Widget build(BuildContext context) {
    final SongProvider songProvider = Provider.of<SongProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
            onPressed: () {
              songProvider.seekToPoint(-15);
            },
            icon: const Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Icon(
                  Icons.keyboard_double_arrow_left,
                ),
                Text("15"),
              ],
            )),
        IconButton(
            onPressed: () {
              songProvider.playPrevious();
            },
            icon: const Icon(
              Icons.skip_previous_rounded,
              size: 40,
            )),
        IconButton(
            onPressed: songProvider.handlePausePlay,
            icon: Icon(
              songProvider.isPlaying
                  ? Icons.pause_circle_filled_rounded
                  : Icons.play_circle_fill_rounded,
              size: 50,
            )),
        IconButton(
            onPressed: () {
              songProvider.playNext();
            },
            icon: const Icon(
              Icons.skip_next_rounded,
              size: 40,
            )),
        IconButton(
            onPressed: () {
              songProvider.seekToPoint(15);
            },
            icon: const Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Icon(
                  Icons.keyboard_double_arrow_right,
                ),
                Text("15"),
              ],
            )),
      ],
    );
  }
}
