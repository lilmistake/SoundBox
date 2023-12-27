import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundbox/core/providers/theme_provider.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return Row(
      children: [
        Image.network(
          "https://i.imgur.com/DaLjcrT.png",
          width: 40,
          filterQuality: FilterQuality.medium,
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
            child: Text("SoundBox",
                style: Theme.of(context).textTheme.titleLarge)),
        IconButton(
            onPressed: () {
              themeProvider.switchTheme();
            },
            icon: Icon(themeProvider.brightness == Brightness.light
                ? Icons.dark_mode
                : Icons.light_mode))
      ],
    );
  }
}
