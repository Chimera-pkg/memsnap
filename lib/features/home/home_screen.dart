import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:learning_gamification/core/controllers/gem_controller.dart';
import 'package:learning_gamification/features/shop/shop_screen.dart';
import 'package:learning_gamification/features/choose_language/choose_language_screen.dart';
import 'package:learning_gamification/features/daily_gift/daily_gift_screen.dart';
import 'package:learning_gamification/features/learning/learning_mode_screen.dart';
import 'package:learning_gamification/shared/widgets/pressable_icon.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  // Configure per-asset scales here. Edit these values in code to change sizes.
  static const Map<String, double> assetScales = {
    'assets/shop.png': 1.3,
    'assets/Languageselect.png': 1.3,
    'assets/dailygift.png': 1.2,
    'assets/diamondbank.png': 2.0,
    'assets/help.png': 1.9,
    'assets/castle.png': 2.0,
    'assets/Learningmode.png': 1.0,
  };

  Widget _navItem(
    BuildContext context,
    String assetPath,
    String label,
    VoidCallback onTap, {
    double iconSize = 84.0,
  }) {
    final scale = assetScales[assetPath] ?? 1.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        PressableIcon(
          onTap: onTap,
          child: Image.asset(
            assetPath,
            width: iconSize * scale,
            height: iconSize * scale,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(color: Colors.white70)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final gemController = context.watch<GemController>();
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
                // Header: diamond, gem count, help, three-dots
                Row(
                  children: [
                    PressableIcon(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ShopScreen()),
                      ),
                      child: Row(
                        children: [
                          // Diamond image with gem count stacked on top
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(
                                'assets/diamondbank.png',
                                width:
                                    headerIconSize *
                                    (assetScales['assets/diamondbank.png'] ??
                                        1.0),
                                height:
                                    headerIconSize *
                                    (assetScales['assets/diamondbank.png'] ??
                                        1.0),
                                fit: BoxFit.contain,
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
                        ],
                      ),
                    ),
                    const Spacer(),
                    PressableIcon(
                      onTap: () {
                        showDialog<void>(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text('Help'),
                            content: const Text(
                              'Help and tips will appear here.',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Close'),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Image.asset(
                        'assets/help.png',
                        width:
                            headerIconSize *
                            (assetScales['assets/help.png'] ?? 1.0),
                        height:
                            headerIconSize *
                            (assetScales['assets/help.png'] ?? 1.0),
                      ),
                    ),
                    const SizedBox(width: 8),
                    PopupMenuButton<String>(
                      icon: const Icon(Icons.more_vert, color: Colors.white),
                      color: Colors.black87,
                      onSelected: (value) {
                        if (value == 'settings') {
                          showDialog<void>(
                            context: context,
                            builder: (_) => const _SettingsDialog(),
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

                // Navigation row: Shop, Choose Language, Daily Gift
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _navItem(context, 'assets/shop.png', 'Shop', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ShopScreen()),
                      );
                    }, iconSize: navIconSize),
                    _navItem(context, 'assets/language2.png', 'Choose', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ChooseLanguageScreen(),
                        ),
                      );
                    }, iconSize: navIconSize),
                    _navItem(context, 'assets/dailygift.png', 'Daily', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const DailyGiftScreen(),
                        ),
                      );
                    }, iconSize: navIconSize),
                  ],
                ),

                const SizedBox(height: 12),

                // Hero castle
                Expanded(
                  child: Center(
                    child: PressableIcon(
                      onTap: null,
                      child: Image.asset(
                        'assets/castle.png',
                        width: 260 * (assetScales['assets/castle.png'] ?? 1.0),
                        height: 260 * (assetScales['assets/castle.png'] ?? 1.0),
                        fit: BoxFit.contain,
                      ),
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
                    child: Image.asset(
                      'assets/Learningmode.png',
                      width:
                          260 * (assetScales['assets/Learningmode.png'] ?? 1.0),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                const SizedBox(height: 18),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SettingsDialog extends StatefulWidget {
  const _SettingsDialog({Key? key}) : super(key: key);

  @override
  State<_SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<_SettingsDialog> {
  static const _kMusicKey = 'music_on';
  bool _musicOn = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _musicOn = prefs.getBool(_kMusicKey) ?? true;
    });
  }

  Future<void> _set(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kMusicKey, value);
    setState(() => _musicOn = value);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Settings'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () => _set(!_musicOn),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/settings1.png',
                  width: 160,
                  height: 160,
                  fit: BoxFit.contain,
                ),
                Positioned(
                  bottom: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _musicOn ? 'Music: ON' : 'Music: OFF',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Music'),
              const SizedBox(width: 8),
              Switch(value: _musicOn, onChanged: (v) => _set(v)),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
      ],
    );
  }
}
