import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:learning_gamification/features/home/home_screen.dart';
import 'package:learning_gamification/features/shop/shop_screen.dart';
import 'package:learning_gamification/providers/gem_provider.dart';
import 'package:learning_gamification/shared/widgets/pressable_icon.dart';
import 'package:provider/provider.dart';

class VictoryScreen extends StatelessWidget {
  const VictoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gemProvider = context.watch<GemProvider>();
    const double headerIconSize = 75.0;
    final audioPlayer = AudioPlayer();

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
                Row(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        PressableIcon(
                          onTap: () async {
                            audioPlayer.play(AssetSource('audio/click.mp3'));

                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ShopScreen(),
                              ),
                            );
                          },
                          assetPath: 'assets/diamondbank.png',
                          baseSize: headerIconSize,
                        ),
                        Text(
                          '${gemProvider.balance}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          useSafeArea: true,
                          barrierColor: Colors.white.withValues(alpha: 0.2),
                          builder: (_) => Dialog(
                            alignment: Alignment.topRight,
                            backgroundColor: Colors.transparent,
                            insetPadding: const EdgeInsets.only(
                              right: 40,
                              top: 80,
                            ),
                            constraints: const BoxConstraints(
                              maxWidth: 200,
                              maxHeight: 200,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                audioPlayer.play(
                                  AssetSource('audio/click.mp3'),
                                );
                                Navigator.pop(context);
                              },
                              child: Image.asset(
                                'assets/settings1.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        );
                      },
                      child: Icon(Icons.menu, color: Colors.white),
                    ),
                  ],
                ),
                Expanded(
                  flex: 4,
                  child: PressableIcon(
                    onTap: () {
                      audioPlayer.play(AssetSource('audio/click.mp3'));
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
