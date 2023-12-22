import 'package:flutter/material.dart';
import 'package:soundbox/home/widgets/home_app_bar.dart';
import 'package:soundbox/home/widgets/home_search_bar.dart';

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
          child: Column(
            children: [
              const HomeAppBar(),
              const SizedBox(
                height: 10,
              ),
              HomeSearchBar(setDrawer: setDrawer),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
