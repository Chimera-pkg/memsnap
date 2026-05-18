import 'package:flutter/material.dart';
import 'package:learning_gamification/providers/language_provider.dart';
import 'package:provider/provider.dart';
import 'package:learning_gamification/providers/gem_provider.dart';
import 'package:learning_gamification/features/shop/shop_screen.dart';
import 'package:learning_gamification/features/daily_gift/daily_gift_screen.dart';
import 'package:learning_gamification/features/learning/learning_mode_screen.dart';
import 'package:learning_gamification/shared/widgets/pressable_icon.dart';
import 'package:learning_gamification/shared/widgets/appbar_widget.dart';
import 'package:learning_gamification/providers/audio_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final langProvider = context.watch<LanguageProvider>();

    final Size screenSize = MediaQuery.of(context).size;
    final double navIconSize = (screenSize.width * 0.25).clamp(60.0, 100.0);
    final double headerIconSize = (screenSize.width * 0.18).clamp(50.0, 75.0);
    final double learningModeSize = (screenSize.width * 0.65).clamp(
      180.0,
      260.0,
    );

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
            padding: EdgeInsets.symmetric(
              horizontal: screenSize.width * 0.04,
              vertical: screenSize.height * 0.015,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const AppbarWidget(showHelpIcon: true),

                // SizedBox(height: screenSize.height * 0.01),

                // Bagian menu tengah
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Transform.translate(
                      offset: const Offset(0, 15),
                      child: PressableIcon(
                        onTap: () async {
                          context.read<AudioProvider>().playSfx(
                            'audio/click.mp3',
                          );
                          context.read<AudioProvider>().pauseMusic();
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ShopScreen(),
                            ),
                          );
                          if (context.mounted) {
                            context.read<AudioProvider>().resumeMusic();
                          }
                        },
                        assetPath: 'assets/shop.png',
                        baseSize: headerIconSize,
                        customScale: 1.4,
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(13, -25),
                      child: PressableIcon(
                        onTap: () {
                          context.read<AudioProvider>().playSfx(
                            'audio/click.mp3',
                          );
                          _showLanguageDialog(langProvider);
                        },
                        assetPath: 'assets/language2.png',
                        baseSize: headerIconSize,
                        customScale: 1.6,
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(12, 15),
                      child: PressableIcon(
                        onTap: () {
                          context.read<AudioProvider>().playSfx(
                            'audio/click.mp3',
                          );
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
                        customScale: 1.2,
                      ),
                    ),
                  ],
                ),

                Expanded(
                  child: Center(
                    child: Transform.scale(
                      scale:
                          1.4, // Anda dapat mengatur angka ini (misalnya 1.3 atau 1.5) jika ingin lebih besar lagi
                      child: Image.asset(
                        langProvider.selectedLanguage != null
                            ? 'assets/castle1.png'
                            : 'assets/castle.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: PressableIcon(
                    onTap: () {
                      context.read<AudioProvider>().playSfx('audio/click.mp3');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LearningModeScreen(),
                        ),
                      );
                    },
                    assetPath: 'assets/Learningmode.png',
                    baseSize: learningModeSize,
                    constraintHeight: false,
                  ),
                ),
                SizedBox(height: screenSize.height * 0.01),
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
                  context.read<AudioProvider>().playSfx(
                    'audio/changelanguage.mp3',
                  );
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
