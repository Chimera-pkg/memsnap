import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class DailyGiftScreen extends StatelessWidget {
  final Future<int> claimFuture;

  const DailyGiftScreen({super.key, required this.claimFuture});

  static final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/purplebg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: FutureBuilder<int>(
          future: claimFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data! > 0) {
              _audioPlayer.play(AssetSource('audio/gemreward.mp3'));
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/chest.png"),
                const SizedBox(height: 20),
                if (snapshot.connectionState == ConnectionState.waiting)
                  const CircularProgressIndicator(color: Colors.white)
                else if (snapshot.hasData && snapshot.data! > 0)
                  Text(
                    "You received ${snapshot.data} gems!",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )
                else
                  const Text(
                    "Daily reward already claimed.",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
