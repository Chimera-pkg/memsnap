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

  static const Map<String, double> assetScales = {
    'assets/shop.png': 1.3,
    'assets/language2.png': 1.0,
    'assets/Languageselect.png': 1.3,
    'assets/dailygift.png': 1.2,
    'assets/diamondbank.png': 2.0,
    'assets/help.png': 1.9,
    'assets/castle.png': 2.0,
    'assets/Learningmode.png': 1.0,
  };

  Widget _buildIcon(
    String assetPath,
    double baseSize, {
    double? customScale,
    bool constraintHeight = true,
  }) {
    final scale = customScale ?? assetScales[assetPath] ?? 1.0;
    final size = baseSize * scale;
    return Image.asset(
      assetPath,
      width: size,
      height: constraintHeight ? size : null,
      fit: BoxFit.contain,
      errorBuilder: (ctx, err, st) => Image.asset(
        'assets/dummy.png',
        width: size,
        height: constraintHeight ? size : null,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _navItem(
    BuildContext context,
    String assetPath,
    String label,
    VoidCallback onTap, {
    double iconSize = 84.0,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        PressableIcon(onTap: onTap, child: _buildIcon(assetPath, iconSize)),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(color: Colors.white70)),
      ],
    );
  }

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
                    PressableIcon(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ShopScreen()),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          _buildIcon('assets/diamondbank.png', headerIconSize),
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
                      child: _buildIcon('assets/help.png', headerIconSize),
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
                        child: _buildIcon('assets/shop.png', headerIconSize),
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
                        child: _buildIcon(
                          'assets/language2.png',
                          headerIconSize,
                          customScale: 1.5,
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(0, 15),
                      child: _navItem(
                        context,
                        'assets/dailygift.png',
                        'Daily',
                        () {
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
                        iconSize: navIconSize,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: Center(
                    child: PressableIcon(
                      onTap: null,
                      child: _buildIcon('assets/castle.png', 260.0),
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
                    child: _buildIcon(
                      'assets/Learningmode.png',
                      260.0,
                      constraintHeight: false,
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
