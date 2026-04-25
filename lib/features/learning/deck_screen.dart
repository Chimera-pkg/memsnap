import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:learning_gamification/features/learning/victory_screen.dart';
import 'package:learning_gamification/features/shop/shop_screen.dart';
import 'package:learning_gamification/providers/gem_provider.dart';
import 'package:learning_gamification/shared/widgets/pressable_icon.dart';
import 'package:provider/provider.dart';

class DeckScreen extends StatefulWidget {
  const DeckScreen({super.key});

  @override
  State<DeckScreen> createState() => _DeckScreenState();
}

class _DeckScreenState extends State<DeckScreen> {
  // Gunakan instance terpisah untuk musik latar agar tidak terinterupsi suara klik
  late AudioPlayer _bgMusicPlayer;
  late AudioPlayer _sfxPlayer;
  bool _isMusicPlaying = true;

  @override
  void initState() {
    super.initState();
    _sfxPlayer = AudioPlayer();
  }

  void _playSfx(String path) {
    _sfxPlayer.play(AssetSource(path));
  }

  @override
  void dispose() {
    // Bersihkan resource saat widget dihancurkan
    _bgMusicPlayer.dispose();
    _sfxPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gemProvider = context.watch<GemProvider>();
    const double headerIconSize = 75.0;

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
                            _playSfx('audio/click.mp3');
                            if (_isMusicPlaying) {
                              _bgMusicPlayer.pause();
                            }
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ShopScreen(),
                              ),
                            );
                            if (_isMusicPlaying) {
                              _bgMusicPlayer.resume();
                            }
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
                                if (_isMusicPlaying) {
                                  _bgMusicPlayer.pause();
                                } else {
                                  _bgMusicPlayer.resume();
                                }
                                setState(() {
                                  _isMusicPlaying = !_isMusicPlaying;
                                });
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
                PressableIcon(
                  onTap: () {
                    _playSfx('audio/click.mp3');
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const VictoryScreen()),
                    );
                  },
                  assetPath: 'assets/dummy.png',
                  baseSize: 500,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
