import 'package:flutter/material.dart';
import 'package:soundbox/pages/home/home_app_bar.dart';
import 'package:soundbox/pages/home/home_playlists_section.dart';
import 'package:soundbox/pages/home/home_queue_section.dart';
import 'package:soundbox/pages/search/search_page.dart';
import 'package:soundbox/widgets/song_control_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget endDrawer = const Drawer();
  void setEndDrawer(Widget newDrawer) {
    setState(() {
      endDrawer = Container(
          decoration: BoxDecoration(
              border: Border.all(
                  color: Theme.of(context).colorScheme.onBackground,
                  strokeAlign: BorderSide.strokeAlignInside)),
          margin: const EdgeInsets.all(10),
          width: 600,
          child: newDrawer);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      endDrawer: endDrawer,
      drawer: const SearchPageWidget(),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                  color: Theme.of(context).colorScheme.onBackground)),
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeQueueSection(),
              Expanded(
                flex: 3,
                child: Stack(
                  children: [
                    HomePlaylistsSection(setEndDrawer: setEndDrawer),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: SongControlBar(setEndDrawer: setEndDrawer))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}