import 'package:flutter/material.dart';
import 'package:soundbox/pages/search/search_result_widget.dart';

class SearchPageWidget extends StatefulWidget {
  const SearchPageWidget({super.key});

  @override
  State<SearchPageWidget> createState() => _SearchPageWidgetState();
}

class _SearchPageWidgetState extends State<SearchPageWidget> {
  String query = "";
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: Border.all(
              strokeAlign: BorderSide.strokeAlignInside,
              color: Theme.of(context).colorScheme.onBackground)),
      padding: const EdgeInsets.all(15),
      width: 400,
      height: double.infinity,
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Search for a Song",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const CloseButton()
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
              controller: controller,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                suffixIcon: IconButton(
                    onPressed: () {
                      if (controller.text.isEmpty) {
                        return;
                      }
                      setState(() {
                        query = controller.text;
                      });
                    },
                    icon: const Icon(Icons.search)),
                hintText: "Start typing to search",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
              )),
          const SizedBox(
            height: 10,
          ),
          Expanded(child: SearchResult(query: query))
        ],
      ),
    );
  }
}
