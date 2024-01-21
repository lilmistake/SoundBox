import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundbox/core/models/playlist_model.dart';
import 'package:soundbox/core/models/user_model.dart';
import 'package:soundbox/providers/user_provider.dart';
import 'package:soundbox/pages/playlist/playlist_page.dart';
import 'package:soundbox/services/pocketbase_service.dart';

class HomePlaylistsSection extends StatelessWidget {
  const HomePlaylistsSection({super.key, required this.setEndDrawer});
  final Function(Widget) setEndDrawer;

  handleCreatePlaylist(UserProvider userProvider) async {

    User? updatedUser = await PocketBaseService.instance
        .createPlaylist("Favourites!", userProvider.user!.id);
    if (updatedUser != null) {
      userProvider.setUser(updatedUser);
    }
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text("My Playlists", style: Theme.of(context).textTheme.titleLarge),
            IconButton(
                onPressed: () => handleCreatePlaylist(userProvider),
                icon: const Icon(Icons.add)),
          ],
        ),
        SizedBox(
          height: 150,
          child: GridView.builder(
              scrollDirection: Axis.horizontal,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 120, crossAxisCount: 1, childAspectRatio: 1),
              shrinkWrap: true,
              itemCount: userProvider.user!.playlists.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setEndDrawer(PlaylistPage(
                        playlistId:
                            userProvider.user!.playlists[index].playlistId));
                    Scaffold.of(context).openEndDrawer();
                  },
                  child: _PlaylistButton(
                      playlist: userProvider.user!.playlists[index]),
                );
              }),
        ),
      ],
    );
  }
}

class _PlaylistButton extends StatelessWidget {
  const _PlaylistButton({required this.playlist});

  final Playlist playlist;

  thumbnail(context) {
    if (playlist.isFav) {
      return Container(
        color: Theme.of(context).colorScheme.surfaceVariant,
        child: const Icon(
          Icons.star,
          size: 50,
        ),
      );
    }
    return Image.network(
      playlist.imageUrl!,
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Expanded(
              child: Container(
            decoration: BoxDecoration(
              border:
                  Border.all(color: Theme.of(context).colorScheme.onBackground),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.onBackground,
                  offset: const Offset(5, 5),
                )
              ],
              color: Theme.of(context).colorScheme.onBackground,
            ),
            child: AspectRatio(
              aspectRatio: 1,
              child: thumbnail(context),
            ),
          )),
          const SizedBox(
            height: 5,
          ),
          FittedBox(child: Text(playlist.name)),
        ],
      ),
    );
  }
}
