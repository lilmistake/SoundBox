import 'package:flutter/material.dart';
import 'package:soundbox/pages/search/search_result_drawer.dart';

class SongSearchBar extends StatelessWidget {
  const SongSearchBar({super.key, required this.setDrawer});

  final Function(Widget) setDrawer;

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Row(
      children: [
        Expanded(
          child: TextField(
              controller: controller,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () {
                      if (controller.text.isEmpty) {
                        return;
                      }
                      setDrawer(SearchResultDrawer(query: controller.text));
                      Scaffold.of(context).openDrawer();
                    },
                    icon: const Icon(Icons.search)),
                hintText: "Search for a Song",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
              )),
        ),
      ],
    );
  }
}
