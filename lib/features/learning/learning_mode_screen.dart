import 'package:flutter/material.dart';
import 'package:learning_gamification/features/learning/deck_screen.dart';
import 'package:learning_gamification/shared/widgets/snackbar_widget.dart';
import 'package:provider/provider.dart';
import 'package:learning_gamification/providers/gem_provider.dart';
import 'package:learning_gamification/shared/widgets/pressable_icon.dart';
import 'package:learning_gamification/shared/widgets/appbar_widget.dart';
import 'package:learning_gamification/providers/audio_provider.dart';

class LearningModeScreen extends StatefulWidget {
  const LearningModeScreen({super.key});

  @override
  State<LearningModeScreen> createState() => _LearningModeScreenState();
}

class _LearningModeScreenState extends State<LearningModeScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gemProvider = context.watch<GemProvider>();

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
                const AppbarWidget(),
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
                        context.read<AudioProvider>().playSfx(
                          'audio/click.mp3',
                        );
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
                          MaterialPageRoute(
                            builder: (_) => const DeckScreen(mode: 'numbers'),
                          ),
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
                        context.read<AudioProvider>().playSfx(
                          'audio/click.mp3',
                        );
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
                          MaterialPageRoute(
                            builder: (_) => const DeckScreen(mode: 'places'),
                          ),
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
                        context.read<AudioProvider>().playSfx(
                          'audio/click.mp3',
                        );
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
