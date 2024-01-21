import 'package:flutter/material.dart';
import 'package:soundbox/core/models/user_model.dart';

/* 
Responsibilit of this provider is to maintain the auth state of the user and its data.
 */
class UserProvider extends ChangeNotifier {
  UserProvider() {
    reorderPlaylists();
  }
  User? _user;
  User? get user => _user;

  reorderPlaylists() {
    if (_user == null) return;
    var i = _user!.playlists.indexWhere((element) => element.isFav);
    if (i != -1) {
      _user!.playlists.insert(0, _user!.playlists.removeAt(i));
    }
  }

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
}
