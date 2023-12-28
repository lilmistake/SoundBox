import 'package:flutter/material.dart';
import 'package:soundbox/core/extensions/with_gap_y.dart';
import 'package:soundbox/pages/home/home_app_bar.dart';
import 'package:soundbox/pages/home/home_queue_list.dart';
import 'package:soundbox/pages/search/search_bar.dart';
import 'package:soundbox/widgets/song_control_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget drawer = const Drawer();

  void setDrawer(Widget newDrawer) {
    setState(() {
      drawer = newDrawer;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HomeAppBar(),
                  SongSearchBar(setDrawer: setDrawer),
                  const Expanded(child:  HomeQueueList())
                ].withGapY(height: 10),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: SongControleBar(setDrawer: setDrawer))
            ],
          ),
        ),
      ),
    );
  }
}


/*
Self host the API
Cache recently searched songs' results
Create artist page - visible by clicking on their name under a song or maybe even by searching(?)
Add functionality to add to favourites
Add functionality to create playlist
Add functionality to play the song
Add functionality to show the lyrics
Add functionality to generate playlists based on interest using ML
 */