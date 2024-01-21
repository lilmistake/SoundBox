import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundbox/providers/theme_provider.dart';
import 'package:soundbox/widgets/bottom_sheet_queue.dart';

class HomeAppBar extends PreferredSize {
  const HomeAppBar(
      {super.key,
      super.preferredSize = const Size(double.infinity, kToolbarHeight + 20),
      super.child = const _AppBar()});
}

class _AppBar extends StatelessWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      decoration: BoxDecoration(
          border:
              Border.all(color: Theme.of(context).colorScheme.onBackground)),
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(5),
      child: Row(
        children: [
          const Text(
            "SoundBox",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          IconButton(
              onPressed: () => showModalBottomSheet(
                    context: context,
                    builder: (context) => const BottomSheetQueue(),
                  ),
              icon: const Icon(Icons.queue_music)),
          IconButton(
              onPressed: Scaffold.of(context).openDrawer,
              icon: const Icon(Icons.search)),
          IconButton(
              onPressed: themeProvider.switchTheme,
              icon: Icon(themeProvider.brightness == Brightness.light
                  ? Icons.dark_mode
                  : Icons.light_mode))
        ],
      ),
    );
  }
}
