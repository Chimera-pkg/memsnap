import 'package:flutter/material.dart';
import 'package:learning_gamification/features/learning/victory_screen.dart';
import 'package:learning_gamification/shared/widgets/appbar_widget.dart';
import 'package:learning_gamification/providers/audio_provider.dart';
import 'package:provider/provider.dart';
import 'package:appinio_swiper/appinio_swiper.dart';

class DeckScreen extends StatefulWidget {
  final String mode;

  const DeckScreen({super.key, required this.mode});

  @override
  State<DeckScreen> createState() => _DeckScreenState();
}

class _DeckScreenState extends State<DeckScreen> {
  late List<String> _cards;

  @override
  void initState() {
    super.initState();

    if (widget.mode == 'numbers') {
      _cards = List.generate(10, (index) => 'assets/number-${index + 1}.png');
    } else if (widget.mode == 'places') {
      _cards = List.generate(4, (index) => 'assets/places-${index + 1}.png');
    } else {
      _cards = [];
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  child: AppinioSwiper(
                    cardCount: _cards.length,
                    onSwipeEnd:
                        (
                          int previousIndex,
                          int targetIndex,
                          SwiperActivity activity,
                        ) {
                          context.read<AudioProvider>().playSfx(
                            'audio/click.mp3',
                          );
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
