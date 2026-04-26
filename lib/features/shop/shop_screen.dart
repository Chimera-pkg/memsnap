import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:learning_gamification/providers/gem_provider.dart';
import 'package:learning_gamification/shared/widgets/snackbar_widget.dart';
import 'package:learning_gamification/shared/widgets/pressable_icon.dart';
import 'package:provider/provider.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  static final AudioPlayer _audioPlayer = AudioPlayer();
  late AudioPlayer _bgMusicPlayer;

  @override
  void initState() {
    super.initState();
    _bgMusicPlayer = AudioPlayer();
    _startBackgroundMusic();
  }

  Future<void> _startBackgroundMusic() async {
    try {
      await _bgMusicPlayer.setReleaseMode(ReleaseMode.loop);
      await _bgMusicPlayer.play(AssetSource('audio/shopmusic.wav'));
    } catch (e) {
      debugPrint("Error play shop background music: $e");
    }
  }

  @override
  void dispose() {
    _bgMusicPlayer.stop();
    _bgMusicPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gemProvider = context.watch<GemProvider>();
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/greenbg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 20.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.topLeft,
                    children: [
                      Image.asset("shop_banner.png"),
                      PressableIcon(
                        onTap: () {
                          if (context.mounted) {
                            _audioPlayer.play(AssetSource('audio/click.mp3'));
                            Navigator.pop(context);
                          }
                        },
                        assetPath: 'close.png',
                        baseSize: 30,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: PressableIcon(
                          onTap: () async {
                            await gemProvider.addGems(50);
                            if (context.mounted) {
                              _audioPlayer.play(
                                AssetSource('audio/gemreward.mp3'),
                              );
                              SnackbarWidget.show(
                                context,
                                message: "50 gems added!",
                                backgroundColor: Colors.green,
                              );
                              Future.delayed(const Duration(seconds: 1));
                              Navigator.pop(context);
                            }
                          },
                          child: Image.asset("assets/50-gems.png"),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: PressableIcon(
                          onTap: () async {
                            await gemProvider.addGems(120);
                            if (context.mounted) {
                              _audioPlayer.play(
                                AssetSource('audio/gemreward.mp3'),
                              );
                              SnackbarWidget.show(
                                context,
                                message: "120 gems added!",
                                backgroundColor: Colors.green,
                              );
                              Future.delayed(const Duration(seconds: 1));
                              Navigator.pop(context);
                            }
                          },
                          child: Transform.scale(
                            scale: 1.04,
                            child: Image.asset("assets/120-gems.png"),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: PressableIcon(
                          onTap: () async {
                            await gemProvider.addGems(300);
                            if (context.mounted) {
                              _audioPlayer.play(
                                AssetSource('audio/gemreward.mp3'),
                              );
                              SnackbarWidget.show(
                                context,
                                message: "300 gems added!",
                                backgroundColor: Colors.green,
                              );
                              Future.delayed(const Duration(seconds: 1));
                              Navigator.pop(context);
                            }
                          },
                          child: Image.asset("assets/300-gems.png"),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: PressableIcon(
                          onTap: () async {
                            await gemProvider.addGems(700);
                            if (context.mounted) {
                              _audioPlayer.play(
                                AssetSource('audio/gemreward.mp3'),
                              );
                              SnackbarWidget.show(
                                context,
                                message: "700 gems added!",
                                backgroundColor: Colors.green,
                              );
                              Future.delayed(const Duration(seconds: 1));
                              Navigator.pop(context);
                            }
                          },
                          child: Transform.scale(
                            scale: 0.94,
                            child: Image.asset("assets/700-gems.png"),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  PressableIcon(
                    onTap: () async {
                      await gemProvider.addGems(1500);
                      if (context.mounted) {
                        _audioPlayer.play(AssetSource('audio/gemreward.mp3'));
                        SnackbarWidget.show(
                          context,
                          message: "1500 gems added!",
                          backgroundColor: Colors.green,
                        );
                        Future.delayed(const Duration(seconds: 1));
                        Navigator.pop(context);
                      }
                    },
                    child: Image.asset(
                      "assets/1500-gems.png",
                      width: double.infinity,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
