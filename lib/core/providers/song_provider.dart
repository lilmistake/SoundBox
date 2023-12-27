import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:soundbox/core/models/lyrics_model.dart';
import 'package:soundbox/core/models/song_model.dart';
import 'package:soundbox/services/saavn_api_service.dart';

class SongProvider extends ChangeNotifier {
  final _queue = ConcatenatingAudioSource(
    useLazyPreparation: true,
    children: [],
  );
  final List<Song> _queueMeta = [];
  final AudioPlayer _player = AudioPlayer();
  int _currentSongIndex = 0;
  bool _isPlaying = false;

  AudioPlayer get player => _player;
  bool get isPlaying => _isPlaying;
  Song? get currentSong =>
      _queueMeta.isEmpty ? null : _queueMeta[_currentSongIndex];
  List<Song>? get currentQueue => _queueMeta;
  ConcatenatingAudioSource get queue => _queue;
  int get currentSongIndex => _currentSongIndex;

  SongProvider() {
    _player.playingStream.listen((state) {
      _isPlaying = state;
    });
    _player.currentIndexStream.listen((index) {
      if (index != null) {
        _currentSongIndex = index;
        notifyListeners();
      }
    });
  }

  Future<void> handlePausePlay() async {
    if (_player.playing) {
      await _player.pause();
    } else {
      await _player.play();
    }
    notifyListeners();
  }

  Future<void> setAudioSource() async {
    await _player.setAudioSource(_queue,
        initialIndex: 0, initialPosition: Duration.zero);
  }

  Future<void> setCurrentSong(Song song) async {
    int c = _currentSongIndex;
    if (_queue.length == 0) c = -1;
    await _queue.insert(
        c + 1, AudioSource.uri(Uri.parse(song.downloadUrls.last.link)));

    if (_queueMeta.isEmpty) await setAudioSource();
    _queueMeta.insert(c + 1, song);
    notifyListeners();
    await Future.delayed(Durations.medium1);
    playNext();
  }

  Future<void> addToQueue(Song song) async {
    await _queue.add(AudioSource.uri(Uri.parse(song.downloadUrls.last.link)));
    if (_queueMeta.isEmpty) await setAudioSource();
    _queueMeta.add(song);
    notifyListeners();
  }

  Future<void> seekToPoint(int seconds) async {
    Duration currentDuration = _player.position;
    await _player.seek(Duration(seconds: seconds + currentDuration.inSeconds));
    notifyListeners();
  }

  Future<void> playPrevious() async {
    Duration currentDuration = _player.position;
    if (currentDuration.inSeconds < 2) {
      await _player.seekToPrevious();
      notifyListeners();
    } else {
      seekToPoint(-currentDuration.inSeconds);
    }
  }

  Future<void> playNext() async {
    await _player.seekToNext();
    if (!_player.playing) await _player.play();
    notifyListeners();
  }

  Stream<Duration> positionStream() {
    return _player.createPositionStream(
      maxPeriod: const Duration(milliseconds: 20),
      minPeriod: const Duration(milliseconds: 20),
    );
  }

  Future<void> getLyrics() async {
    Song song = _queueMeta[_currentSongIndex];
    if (song.lyrics == null) {
      if (song.hasLyrics == false) {
        _queueMeta[_currentSongIndex].lyrics = 'No Lyrics Found';
      } else {
        Lyrics? lyrics = await SaavnApiService().getLyrics(song.id);
        if (lyrics == null) {
          _queueMeta[_currentSongIndex].lyrics = 'No Lyrics Found';
        } else {
          _queueMeta[_currentSongIndex].lyrics = lyrics.lyrics;
        }
      }
      notifyListeners();
    }
  }
}
