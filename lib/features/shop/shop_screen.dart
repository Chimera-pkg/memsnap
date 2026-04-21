import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:learning_gamification/providers/gem_provider.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gemController = context.read<GemProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Gem Shop')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildPack(
            context,
            title: 'Gem Satchel',
            amount: 50,
            priceText: '\$4.99',
            onBuy: () async {
              await gemController.addGems(50);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Purchased 50 gems')),
              );
            },
          ),
          const SizedBox(height: 12),
          _buildPack(
            context,
            title: 'Gem Wagon',
            amount: 300,
            priceText: '\$24.99',
            onBuy: () async {
              await gemController.addGems(300);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Purchased 300 gems')),
              );
            },
          ),
          const SizedBox(height: 12),
          _buildPack(
            context,
            title: 'Gem Vault',
            amount: 1500,
            priceText: '\$49.99',
            onBuy: () async {
              await gemController.addGems(1500);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Purchased 1500 gems')),
              );
            },
          ),
          const SizedBox(height: 24),
          const Text(
            'Note: IAP placeholders — integrate `in_app_purchase` for real purchases.',
          ),
        ],
      ),
    );
  }

  Widget _buildPack(
    BuildContext context, {
    required String title,
    required int amount,
    required String priceText,
    required VoidCallback onBuy,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            CircleAvatar(child: Text(amount.toString())),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(priceText),
                ],
              ),
            ),
            ElevatedButton(onPressed: onBuy, child: const Text('Buy')),
          ],
        ),
      ),
    );
  }
}
