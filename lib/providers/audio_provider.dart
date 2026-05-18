import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioProvider extends ChangeNotifier {
  late AudioPlayer _bgMusicPlayer;
  late AudioPlayer _sfxPlayer;
  bool _isMusicPlaying = true;

  bool get isMusicPlaying => _isMusicPlaying;

  AudioProvider() {
    _bgMusicPlayer = AudioPlayer();
    _sfxPlayer = AudioPlayer();
    _startBackgroundMusic();
  }

  Future<void> _startBackgroundMusic() async {
    try {
      await _bgMusicPlayer.setReleaseMode(ReleaseMode.loop);
      await _bgMusicPlayer.play(AssetSource('audio/mainmusic.wav'));
    } catch (e) {
      debugPrint("Error play background music: $e");
    }
  }

  void playSfx(String path) {
    _sfxPlayer.play(AssetSource(path));
  }

  void toggleMusic() {
    if (_isMusicPlaying) {
      _bgMusicPlayer.pause();
    } else {
      _bgMusicPlayer.resume();
    }
    _isMusicPlaying = !_isMusicPlaying;
    notifyListeners();
  }
  
  void pauseMusic() {
    if (_isMusicPlaying) {
      _bgMusicPlayer.pause();
    }
  }
  
  void resumeMusic() {
    if (_isMusicPlaying) {
      _bgMusicPlayer.resume();
    }
  }

  @override
  void dispose() {
    _bgMusicPlayer.dispose();
    _sfxPlayer.dispose();
    super.dispose();
  }
}
