import 'package:flutter/material.dart';
import 'package:learning_gamification/providers/gem_provider.dart';
import 'package:learning_gamification/shared/widgets/snackbar_widget.dart';
import 'package:learning_gamification/shared/widgets/pressable_icon.dart';
import 'package:provider/provider.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

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
                  Row(
                    children: [
                      Expanded(
                        child: PressableIcon(
                          onTap: () async {
                            await gemProvider.addGems(50);
                            if (context.mounted) {
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
