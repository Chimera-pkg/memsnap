import 'package:flutter/material.dart';

/// A small widget that performs a "timbul" (pop) animation on tap,
/// then calls `onTap` after the animation completes.
class PressableIcon extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final double popScale;
  final Duration duration;

  const PressableIcon({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.popScale = 1.08,
    this.duration = const Duration(milliseconds: 120),
  });

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

        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: handleTap,
          onLongPress: onLongPress != null ? handleLongPress : null,
          child: AnimatedScale(
            scale: scale,
            duration: duration,
            curve: Curves.easeOutBack,
            child: child,
          ),
        );
      },
    );
  }
}
