import 'package:pocketbase/pocketbase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soundbox/core/models/playlist_model.dart';
import 'package:soundbox/core/models/song_model.dart';
import 'package:soundbox/core/models/user_model.dart';


/* 
Class responsibile for all transactions with Pocketbase database
 */
class PocketBaseService {
  static late final PocketBase _pb;
  static PocketBaseService? _instance;
  SharedPreferences? prefs;

  PocketBaseService._internal(this.prefs);

  static PocketBaseService get instance => _instance!;
  bool get hasValidToken => _pb.authStore.isValid;
  void clearAuthStore() => _pb.authStore.clear();

  static Future<PocketBaseService> init() async {
    if (_instance == null) {
      var sp = await SharedPreferences.getInstance();

      // Init the Auth Store - SharedPreferences Instance
      final store = AsyncAuthStore(
        save: (String data) async => sp.setString('pb_auth', data),
        initial: sp.getString('pb_auth'),
      );

      // Connect to the PocketBase Server instance
      _pb = PocketBase('http://127.0.0.1:8090', authStore: store);
      _instance = PocketBaseService._internal(sp);
    }
    return _instance!;
  }


  Future<User> login(String username, String password) async {
    var data = await _pb
        .collection("users")
        .authWithPassword(username, password, expand: "playlists");
    _pb.authStore.save(data.token, _pb.authStore.model);
    return getUser();
  }

  adminLogin() async {
    _pb.authStore.clear();
    await _pb.admins.authWithPassword('test@example.com', '1234567890');
  }

  Future<RecordModel?> createUser(String username, String password) async {
    try {
      var response = await _pb.collection("users").create(body: {
        "username": username,
        "password": password,
        "passwordConfirm": password,
      });
      return response;
    } catch (e) {
      print(e);
      return null;
    }
  }

  createSong(Song song) async {
    await _pb.collection("songs").create(body: song.toJson());
  }

  Future<User?> createPlaylist(String name, String userId) async {
    try {
      var response = await _pb.collection("playlists").create(body: {
        "name": name,
        "isFav": true,
        "duration": 0,
      });
      Playlist newPlaylist = Playlist.fromJson(response.toJson());
      response = await _pb.collection("users").update(userId,
          body: {'playlists+': newPlaylist.playlistId}, expand: "playlists");

      return User.fromJson(response.toJson());
    } catch (e) {
      return null;
    }
  }

  Future<Playlist?> getPlaylist(String id) async {
    try {
      var data = await _pb
          .collection("playlists")
          .getFullList(expand: 'songs', query: {'id': id});
      return Playlist.fromJson(data[0].toJson());
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<User> getUser() async {
    var data = await _pb.collection("users").getFullList(expand: 'playlists');
    return User.fromJson(data[0].toJson());
  }

}
