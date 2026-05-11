import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:learning_gamification/features/learning/deck_screen.dart';
import 'package:learning_gamification/shared/widgets/snackbar_widget.dart';
import 'package:provider/provider.dart';
import 'package:learning_gamification/providers/gem_provider.dart';
import 'package:learning_gamification/features/shop/shop_screen.dart';
import 'package:learning_gamification/shared/widgets/pressable_icon.dart';

class LearningModeScreen extends StatefulWidget {
  const LearningModeScreen({super.key});

  @override
  State<LearningModeScreen> createState() => _LearningModeScreenState();
}

class _LearningModeScreenState extends State<LearningModeScreen> {
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
                        _playSfx('audio/click.mp3');
                        showDialog(
                          context: context,
                          useSafeArea: true,
                          barrierColor: Colors.white.withValues(alpha: 0.2),
                          builder: (_) => Dialog(
                            alignment: Alignment.topRight,
                            backgroundColor: Colors.transparent,
                            insetPadding: const EdgeInsets.only(top: 100),
                            constraints: const BoxConstraints(
                              maxWidth: 200,
                              maxHeight: 300,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (_isMusicPlaying) {
                                      _bgMusicPlayer.pause();
                                    } else {
                                      _bgMusicPlayer.resume();
                                    }
                                    setState(() {
                                      _isMusicPlaying = !_isMusicPlaying;
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Image.asset(
                                    _isMusicPlaying
                                        ? 'assets/music_off.png'
                                        : 'assets/music_on.png',
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: 50,
                                  ),
                                ),
                                // GestureDetector(
                                //   onTap: () {
                                //     if (_isMusicPlaying) {
                                //       _bgMusicPlayer.pause();
                                //     } else {
                                //       _bgMusicPlayer.resume();
                                //     }
                                //     setState(() {
                                //       _isMusicPlaying = !_isMusicPlaying;
                                //     });
                                //     Navigator.pop(context);
                                //   },
                                //   child: Image.asset(
                                //     _isMusicPlaying
                                //         ? 'assets/sound_off.png'
                                //         : 'assets/sound_on.png',
                                //     fit: BoxFit.cover,
                                //     width: double.infinity,
                                //     height: 50,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: const Icon(Icons.menu, color: Colors.white),
                    ),
                  ],
                ),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Image.asset(
                      'assets/learningdeck.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: PressableIcon(
                      onTap: () {
                        _playSfx('audio/click.mp3');
                        if (gemProvider.balance < 50) {
                          return SnackbarWidget.show(
                            context,
                            message: 'Gems is not enough',
                            backgroundColor: Colors.red,
                          );
                        }
                        gemProvider.spendGems(context, 50);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const DeckScreen(mode: 'numbers')),
                        );
                      },
                      child: Image.asset(
                        'assets/numbers.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: PressableIcon(
                      onTap: () {
                        _playSfx('audio/click.mp3');
                        if (gemProvider.balance < 50) {
                          return SnackbarWidget.show(
                            context,
                            message: 'Gems is not enough',
                            backgroundColor: Colors.red,
                          );
                        }
                        gemProvider.spendGems(context, 50);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const DeckScreen(mode: 'places')),
                        );
                      },
                      child: Image.asset(
                        'assets/places.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: PressableIcon(
                      onTap: () {
                        _playSfx('audio/click.mp3');
                      },
                      child: Image.asset(
                        'assets/eating.png',
                        fit: BoxFit.contain,
                      ),
                    ),
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
