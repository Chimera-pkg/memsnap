import 'package:flutter/material.dart';
import 'package:learning_gamification/features/home/home_screen.dart';
import 'package:learning_gamification/shared/widgets/pressable_icon.dart';
import 'package:learning_gamification/shared/widgets/appbar_widget.dart';
import 'package:learning_gamification/providers/audio_provider.dart';
import 'package:provider/provider.dart';

class VictoryScreen extends StatelessWidget {
  const VictoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/purplebg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const AppbarWidget(),
                Expanded(
                  flex: 4,
                  child: PressableIcon(
                    onTap: () {
                      context.read<AudioProvider>().playSfx('audio/click.mp3');
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const HomeScreen()),
                      );
                    },
                    assetPath: 'assets/victory.png',
                    baseSize: 500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
