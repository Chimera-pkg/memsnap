import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  // Gunakan static agar instance player tetap sama
  static final AudioPlayer _audioPlayer = AudioPlayer();
  static bool _isNavigating = false;

  void _startApp(BuildContext context) {
    // WidgetsBinding memastikan kode ini jalan SETELAH build selesai
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (_isNavigating) return;
      _isNavigating = true;

      try {
        await _audioPlayer.play(AssetSource('audio/appintro.mp3'));
      } catch (e) {
        debugPrint("Error play audio: $e");
      }

      // Beri jeda sesuai durasi splash (misal 3 detik)
      await Future.delayed(const Duration(seconds: 3));

      if (context.mounted) {
        // Reset flag sebelum pindah agar kalau balik lagi bisa jalan (opsional)
        _isNavigating = false;
        Navigator.of(context).pushReplacementNamed('/');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Panggil fungsi startApp
    _startApp(context);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/intro.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
