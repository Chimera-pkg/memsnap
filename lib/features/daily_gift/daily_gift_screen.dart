import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:learning_gamification/core/controllers/gem_controller.dart';

class DailyGiftScreen extends StatelessWidget {
  const DailyGiftScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gemController = context.read<GemController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Daily Gift')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Daily Gift',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () async {
                  final reward = await gemController.claimDailyIfEligible();
                  final msg = reward > 0
                      ? 'You received $reward gems!'
                      : 'Daily reward already claimed.';
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(msg)));
                },
                child: const Text('Claim Daily Reward'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
