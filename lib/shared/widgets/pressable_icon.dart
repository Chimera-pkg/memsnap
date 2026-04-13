import 'package:flutter/material.dart';

/// A small widget that performs a "timbul" (pop) animation on tap,
/// then calls `onTap` after the animation completes.
class PressableIcon extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final double popScale;
  final Duration duration;

  const PressableIcon({
    Key? key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.popScale = 1.08,
    this.duration = const Duration(milliseconds: 120),
  }) : super(key: key);

  @override
  State<PressableIcon> createState() => _PressableIconState();
}

class _PressableIconState extends State<PressableIcon> {
  double _scale = 1.0;
  bool _busy = false;

  Future<void> _handleTap() async {
    if (_busy) return;
    _busy = true;
    setState(() => _scale = widget.popScale);
    await Future.delayed(widget.duration);
    setState(() => _scale = 1.0);
    await Future.delayed(widget.duration);
    _busy = false;
    widget.onTap?.call();
  }

  Future<void> _handleLongPress() async {
    if (widget.onLongPress == null) return;
    if (_busy) return;
    _busy = true;
    setState(() => _scale = widget.popScale);
    await Future.delayed(widget.duration);
    setState(() => _scale = 1.0);
    await Future.delayed(widget.duration);
    _busy = false;
    widget.onLongPress?.call();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: _handleTap,
      onLongPress: widget.onLongPress != null ? _handleLongPress : null,
      child: AnimatedScale(
        scale: _scale,
        duration: widget.duration,
        curve: Curves.easeOutBack,
        child: widget.child,
      ),
    );
  }
}
