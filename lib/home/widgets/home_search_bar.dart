import 'package:flutter/material.dart';
import 'package:soundbox/search/search_results.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key, required this.setDrawer});

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
                      setDrawer(SearchResultsDrawer(query: controller.text));
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
