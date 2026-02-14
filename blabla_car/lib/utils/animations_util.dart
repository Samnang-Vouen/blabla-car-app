import 'package:flutter/material.dart';

class AnimationsUtil {
  static Route<T> createBottomToTopRoute<T>(Widget screen) {
    const begin = Offset(0.0, 1.0);
    const end = Offset(0.0, 0.0);
    return _createAnimatedRoute<T>(screen, begin, end);
  }

  static Route<T> _createAnimatedRoute<T>(
    Widget screen,
    Offset begin,
    Offset end,
  ) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionDuration: const Duration(milliseconds: 350),
      reverseTransitionDuration: const Duration(milliseconds: 250),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final tween = Tween<Offset>(begin: begin, end: end).chain(
          CurveTween(curve: Curves.fastOutSlowIn),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
