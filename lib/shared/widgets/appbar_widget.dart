import 'package:flutter/material.dart';
import 'package:learning_gamification/features/shop/shop_screen.dart';
import 'package:learning_gamification/providers/audio_provider.dart';
import 'package:learning_gamification/providers/gem_provider.dart';
import 'package:learning_gamification/shared/widgets/pressable_icon.dart';
import 'package:provider/provider.dart';

class AppbarWidget extends StatelessWidget {
  final bool showHelpIcon;

  const AppbarWidget({
    super.key,
    this.showHelpIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    final gemProvider = context.watch<GemProvider>();
    final audioProvider = context.watch<AudioProvider>();

    final Size screenSize = MediaQuery.of(context).size;
    final double headerIconSize = (screenSize.width * 0.18).clamp(50.0, 75.0);

    return Row(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            PressableIcon(
              onTap: () async {
                audioProvider.playSfx('audio/click.mp3');
                audioProvider.pauseMusic();
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ShopScreen(),
                  ),
                );
                audioProvider.resumeMusic();
              },
              assetPath: 'assets/diamondbank.png',
              baseSize: headerIconSize,
            ),
            Text(
              '${gemProvider.balance}',
              style: TextStyle(
                color: Colors.white,
                fontSize: (headerIconSize * 0.2).clamp(12.0, 16.0),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const Spacer(),
        if (showHelpIcon)
          PressableIcon(
            onTap: () {
              audioProvider.playSfx('audio/click.mp3');
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
            audioProvider.playSfx('audio/click.mp3');
            showDialog(
              context: context,
              useSafeArea: true,
              barrierColor: Colors.white.withOpacity(0.2),
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
                        audioProvider.toggleMusic();
                        Navigator.pop(context);
                      },
                      child: Consumer<AudioProvider>(
                        builder: (context, audio, child) {
                          return Image.asset(
                            audio.isMusicPlaying
                                ? 'assets/music_on.png'
                                : 'assets/music_off.png',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 50,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          child: const Icon(Icons.menu, color: Colors.white),
        ),
      ],
    );
  }
}
