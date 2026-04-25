import 'package:flutter/material.dart';

/// A small widget that performs a "timbul" (pop) animation on tap,
/// then calls `onTap` after the animation completes.
class PressableIcon extends StatelessWidget {
  final Widget? child;
  final String? assetPath;
  final double? baseSize;
  final double? customScale;
  final bool constraintHeight;

  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final double popScale;
  final Duration duration;

  const PressableIcon({
    super.key,
    this.child,
    this.assetPath,
    this.baseSize,
    this.customScale,
    this.constraintHeight = true,
    this.onTap,
    this.onLongPress,
    this.popScale = 1.08,
    this.duration = const Duration(milliseconds: 120),
  }) : assert(child != null || (assetPath != null && baseSize != null));

  static const Map<String, double> defaultScales = {
    'assets/shop.png': 1.3,
    'assets/language2.png': 1.0,
    'assets/Languageselect.png': 1.3,
    'assets/dailygift.png': 1.2,
    'assets/diamondbank.png': 2.0,
    'assets/help.png': 1.9,
    'assets/castle.png': 2.0,
    'assets/Learningmode.png': 1.0,
  };

  @override
  Widget build(BuildContext context) {
    double scale = 1.0;
    bool busy = false;

    return StatefulBuilder(
      builder: (context, setState) {
        Future<void> handleTap() async {
          if (busy) return;
          busy = true;
          setState(() => scale = popScale);
          await Future.delayed(duration);
          setState(() => scale = 1.0);
          await Future.delayed(duration);
          busy = false;
          onTap?.call();
        }

        Future<void> handleLongPress() async {
          if (onLongPress == null) return;
          if (busy) return;
          busy = true;
          setState(() => scale = popScale);
          await Future.delayed(duration);
          setState(() => scale = 1.0);
          await Future.delayed(duration);
          busy = false;
          onLongPress?.call();
        }

        Widget content;
        if (assetPath != null && baseSize != null) {
          final computedScale = customScale ?? defaultScales[assetPath!] ?? 1.0;
          final size = baseSize! * computedScale;
          content = Image.asset(
            assetPath!,
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
        } else {
          content = child!;
        }

        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: onTap != null ? handleTap : null,
          onLongPress: onLongPress != null ? handleLongPress : null,
          child: AnimatedScale(
            scale: scale,
            duration: duration,
            curve: Curves.easeOutBack,
            child: content,
          ),
        );
      },
    );
  }
}
