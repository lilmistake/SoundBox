import 'package:flutter/material.dart';
import 'package:soundbox/core/models/song_model.dart';
import 'package:audioplayers/audioplayers.dart';

/* 
Responsibility of this Provider is to maintain a global song player state, pause, play, seek and manage the current queue of songs.
 */
class SongProvider extends ChangeNotifier {
  final List<Song> _queue = [];
  final AudioPlayer _player = AudioPlayer();
  int _currentSongIndex = -1;
  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;

  Song? get currentSong => _queue.isEmpty ? null : _queue[_currentSongIndex];
  List<Song>? get queue => _queue;
  int get currentSongIndex => _currentSongIndex;

  SongProvider() {
    _player.onPlayerStateChanged.listen((event) {
      if (event == PlayerState.playing) {
        _isPlaying = true;
        notifyListeners();
      } else if (event == PlayerState.paused) {
        _isPlaying = false;
        notifyListeners();
      } else if (event == PlayerState.completed) {
        playNext();
        notifyListeners();
      }
    });
  }

  void addToQueue(Song song) async {
    _queue.add(song);
    notifyListeners();
  }

  void playSongNext(Song song) async {
    _queue.insert(_currentSongIndex + 1, song);
    notifyListeners();
  }

  Future<void> addMultipleToQueue(List<Song> songs) async {
    if (_currentSongIndex == -1) _currentSongIndex = 0;
    _queue.addAll(songs);
    notifyListeners();
  }

  Future<void> handlePausePlay() async {
    if (_player.state == PlayerState.playing) {
      await _player.pause();
    } else {
      if (_player.state == PlayerState.stopped) {
        await _player.play(UrlSource(_queue.first.downloadUrls.last.link));
      } else if (_player.state == PlayerState.paused) {
        await _player.resume();
      }
    }
    notifyListeners();
  }

  Future<void> setCurrentSong(Song song) async {
    _queue.insert(_currentSongIndex + 1, song);
    playNext();
  }

  Future<void> seekToPoint(int seconds) async {
    Duration? currentDuration = await _player.getCurrentPosition();
    await _player
        .seek(Duration(seconds: seconds + (currentDuration?.inSeconds ?? 0)));
    notifyListeners();
  }

  Future<void> playPrevious() async {
    Duration? currentDuration = await _player.getCurrentPosition();
    currentDuration ??= Duration.zero;

    if (_currentSongIndex == 0) {
      return seekToPoint(-currentDuration.inSeconds);
    }

    if (currentDuration.inSeconds < 2) {
      _currentSongIndex -= 1;
      _player.stop();
      _player.play(UrlSource(
          _queue.elementAt(_currentSongIndex).downloadUrls.last.link));
      notifyListeners();
    } else {
      seekToPoint(-currentDuration.inSeconds);
    }
  }

  Future<void> playNext() async {
    if (_currentSongIndex >= _queue.length - 1) return;
    _currentSongIndex += 1;
    _player.stop();
    _player.play(
        UrlSource(_queue.elementAt(_currentSongIndex).downloadUrls.last.link));
    notifyListeners();
  }

  Stream<Duration> positionStream() {
    return _player.onPositionChanged;
  }

  void setLyrics(String lyrics, int index) {
    _queue[index].lyrics = lyrics;
    notifyListeners();
  }
}
