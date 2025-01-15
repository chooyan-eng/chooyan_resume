import 'package:animated_to/animated_to.dart';
import 'package:flutter/material.dart';

class AnimatedAppearing extends StatelessWidget {
  const AnimatedAppearing({
    super.key,
    required this.child,
    required this.isVisible,
    required this.globalKey,
    required this.delayIndex,
    required this.animationEnabled,
    this.onEnd,
  });

  final Widget child;
  final bool isVisible;
  final GlobalKey globalKey;
  final int delayIndex;
  final VoidCallback? onEnd;
  final bool animationEnabled;

  @override
  Widget build(BuildContext context) {
    final duration = Duration(milliseconds: 500 + delayIndex * 100);
    return AnimatedTo(
      globalKey: globalKey,
      enabled: animationEnabled,
      duration: duration,
      slidingFrom: const Offset(0, 100),
      controller: PrimaryScrollController.of(context),
      curve: Curves.easeInOut,
      onEnd: (_) => onEnd?.call(),
      child: AnimatedOpacity(
        opacity: isVisible ? 1.0 : 0.0,
        duration: duration,
        child: child,
      ),
    );
  }
}
