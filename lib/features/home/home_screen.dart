import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:learning_gamification/providers/gem_provider.dart';
import 'package:learning_gamification/features/shop/shop_screen.dart';
import 'package:learning_gamification/features/choose_language/choose_language_screen.dart';
import 'package:learning_gamification/features/daily_gift/daily_gift_screen.dart';
import 'package:learning_gamification/features/learning/learning_mode_screen.dart';
import 'package:learning_gamification/shared/widgets/pressable_icon.dart';
import 'settings_dialog.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gemController = context.watch<GemProvider>();
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
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ShopScreen(),
                            ),
                          ),
                          assetPath: 'assets/diamondbank.png',
                          baseSize: headerIconSize,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${gemController.balance}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    PressableIcon(
                      onTap: () {
                        showDialog<void>(
                          context: context,
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
                    PopupMenuButton<String>(
                      icon: const Icon(Icons.more_vert, color: Colors.white),
                      color: Colors.black87,
                      onSelected: (value) {
                        if (value == 'settings') {
                          showDialog<void>(
                            context: context,
                            builder: (_) => const SettingsDialog(),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Selected: $value')),
                          );
                        }
                      },
                      itemBuilder: (ctx) => const [
                        PopupMenuItem(
                          value: 'settings',
                          child: Text('Settings'),
                        ),
                        PopupMenuItem(value: 'about', child: Text('About')),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Transform.translate(
                      offset: const Offset(0, 15),
                      child: PressableIcon(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const ShopScreen()),
                        ),
                        assetPath: 'assets/shop.png',
                        baseSize: headerIconSize,
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(0, -25),
                      child: PressableIcon(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ChooseLanguageScreen(),
                            ),
                          );
                        },
                        child: PressableIcon(
                          assetPath: 'assets/language2.png',
                          baseSize: headerIconSize,
                          customScale: 1.5,
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(0, 15),
                      child: PressableIcon(
                        onTap: () {
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
                const SizedBox(height: 12),
                Expanded(
                  child: Center(
                    child: PressableIcon(
                      assetPath: 'assets/castle.png',
                      baseSize: 260.0,
                    ),
                  ),
                ),
                Center(
                  child: PressableIcon(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LearningModeScreen(),
                      ),
                    ),
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
}
