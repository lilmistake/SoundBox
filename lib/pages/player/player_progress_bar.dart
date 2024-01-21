import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundbox/providers/song_provider.dart';

class PlayerProgressBar extends StatefulWidget {
  const PlayerProgressBar({super.key});

  @override
  State<PlayerProgressBar> createState() => _PlayerProgressBarState();
}

class _PlayerProgressBarState extends State<PlayerProgressBar> {
  static int position = 0;
  double? dragPosition;
  String secondsToString(int seconds) {
    return "${(seconds / 60).floor()}:${(seconds % 60).toString().length == 1 ? '0' : ''}${seconds % 60}";
  }

  @override
  Widget build(BuildContext context) {
    SongProvider songProvider = Provider.of<SongProvider>(context);
    if (songProvider.currentSong == null) return const SizedBox();
    return StreamBuilder(
        stream: songProvider.positionStream(),
        builder: (c, snapshot) {
          int seconds = snapshot.data?.inSeconds ?? position;
          position = seconds;
          return Stack(
            alignment: Alignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).colorScheme.onBackground)),
                child: Slider(
                    activeColor: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.5),
                    value: dragPosition ??
                        (seconds / songProvider.currentSong!.duration),
                    onChangeEnd: (v) {
                      songProvider.seekToPoint(
                          (songProvider.currentSong!.duration * v).floor() -
                              seconds);
                      dragPosition = null;
                    },
                    onChanged: (v) {
                      setState(() {
                        dragPosition = v;
                      });
                    }),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      secondsToString(seconds),
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontWeight: FontWeight.w900),
                    ),
                    Text(
                      secondsToString(songProvider.currentSong!.duration),
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
