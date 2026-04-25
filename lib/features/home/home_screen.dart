import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:learning_gamification/providers/language_provider.dart';
import 'package:provider/provider.dart';
import 'package:learning_gamification/providers/gem_provider.dart';
import 'package:learning_gamification/features/shop/shop_screen.dart';
import 'package:learning_gamification/features/daily_gift/daily_gift_screen.dart';
import 'package:learning_gamification/features/learning/learning_mode_screen.dart';
import 'package:learning_gamification/shared/widgets/pressable_icon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Gunakan instance terpisah untuk musik latar agar tidak terinterupsi suara klik
  late AudioPlayer _bgMusicPlayer;
  late AudioPlayer _sfxPlayer;
  bool _isMusicPlaying = true;

  @override
  void initState() {
    super.initState();
    _bgMusicPlayer = AudioPlayer();
    _sfxPlayer = AudioPlayer();

    _startBackgroundMusic();
  }

  Future<void> _startBackgroundMusic() async {
    try {
      // Set agar musik berputar terus menerus (looping)
      await _bgMusicPlayer.setReleaseMode(ReleaseMode.loop);
      await _bgMusicPlayer.play(AssetSource('audio/mainmusic.wav'));
    } catch (e) {
      debugPrint("Error play background music: $e");
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
    final langProvider = context.watch<LanguageProvider>();

    const double navIconSize = 100.0;
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
                    PressableIcon(
                      onTap: () {
                        _playSfx('audio/click.mp3');
                        showDialog(
                          context: context,
                          barrierColor: Colors.white.withOpacity(0.2),
                          builder: (_) => AlertDialog(
                            contentPadding: EdgeInsets.zero,
                            content: Image.asset(
                              'assets/help_c.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        );
                      },
                      assetPath: 'assets/help.png',
                      baseSize: headerIconSize,
                    ),
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
                // Bagian menu tengah
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Transform.translate(
                      offset: const Offset(0, 15),
                      child: PressableIcon(
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
                        assetPath: 'assets/shop.png',
                        baseSize: headerIconSize,
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(0, -25),
                      child: PressableIcon(
                        onTap: () {
                          _playSfx('audio/click.mp3');
                          _showLanguageDialog(langProvider);
                        },
                        assetPath: 'assets/language2.png',
                        baseSize: headerIconSize,
                        customScale: 1.5,
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(0, 15),
                      child: PressableIcon(
                        onTap: () {
                          _playSfx('audio/click.mp3');
                          final claimFuture = context
                              .read<GemProvider>()
                              .claimDailyIfEligible();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  DailyGiftScreen(claimFuture: claimFuture),
                            ),
                          );
                        },
                        assetPath: 'assets/dailygift.png',
                        baseSize: navIconSize,
                      ),
                    ),
                  ],
                ),

                Expanded(
                  child: Center(
                    child: PressableIcon(
                      assetPath: langProvider.selectedLanguage != null
                          ? 'assets/castle1.png'
                          : 'assets/castle.png',
                      baseSize: 260.0,
                    ),
                  ),
                ),
                Center(
                  child: PressableIcon(
                    onTap: () {
                      _playSfx('audio/click.mp3');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LearningModeScreen(),
                        ),
                      );
                    },
                    assetPath: 'assets/Learningmode.png',
                    baseSize: 260.0,
                    constraintHeight: false,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper untuk dialog bahasa agar kode build lebih bersih
  void _showLanguageDialog(LanguageProvider langProvider) {
    showDialog(
      context: context,
      barrierColor: Colors.white.withOpacity(0.2),
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          child: Column(
            children: ['Spanish', 'French', 'Chinese'].map((lang) {
              return GestureDetector(
                onTap: () {
                  _playSfx('audio/changelanguage.mp3');
                  langProvider.setSelectedLanguage(context, lang);
                  Navigator.pop(context);
                },
                child: Image.asset("assets/${lang.toLowerCase()}.png"),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
