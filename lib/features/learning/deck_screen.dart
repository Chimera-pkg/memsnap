import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:learning_gamification/features/learning/victory_screen.dart';
import 'package:learning_gamification/features/shop/shop_screen.dart';
import 'package:learning_gamification/providers/gem_provider.dart';
import 'package:learning_gamification/shared/widgets/pressable_icon.dart';
import 'package:provider/provider.dart';
import 'package:appinio_swiper/appinio_swiper.dart';

class DeckScreen extends StatefulWidget {
  final String mode;

  const DeckScreen({super.key, required this.mode});

  @override
  State<DeckScreen> createState() => _DeckScreenState();
}

class _DeckScreenState extends State<DeckScreen> {
  // Gunakan instance terpisah untuk musik latar agar tidak terinterupsi suara klik
  late AudioPlayer _bgMusicPlayer;
  late AudioPlayer _sfxPlayer;
  bool _isMusicPlaying = true;

  late List<String> _cards;

  @override
  void initState() {
    super.initState();
    _sfxPlayer = AudioPlayer();

    if (widget.mode == 'numbers') {
      _cards = List.generate(10, (index) => 'assets/number-${index + 1}.png');
    } else if (widget.mode == 'places') {
      _cards = List.generate(4, (index) => 'assets/places-${index + 1}.png');
    } else {
      _cards = [];
    }
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
                  child: AppinioSwiper(
                    cardCount: _cards.length,
                    onSwipeEnd:
                        (
                          int previousIndex,
                          int targetIndex,
                          SwiperActivity activity,
                        ) {
                          _playSfx('audio/click.mp3');
                        },
                    onEnd: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const VictoryScreen(),
                        ),
                      );
                    },
                    cardBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        child: Image.asset(_cards[index], fit: BoxFit.cover),
                      );
                    },
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
