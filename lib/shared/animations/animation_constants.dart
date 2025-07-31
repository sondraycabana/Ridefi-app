import 'package:flutter/material.dart';

class AnimationConstants {
  // Duration constants
  static const Duration fastAnimation = Duration(milliseconds: 300);
  static const Duration normalAnimation = Duration(milliseconds: 600);
  static const Duration slowAnimation = Duration(milliseconds: 800);
  static const Duration extraSlowAnimation = Duration(milliseconds: 1200);

  // Additional animation durations
  static const Duration ultraFast = Duration(milliseconds: 150);
  static const Duration pageTransition = Duration(milliseconds: 300);
  static const Duration modalTransition = Duration(milliseconds: 250);
  static const Duration hoverDuration = Duration(milliseconds: 150);

  // Stagger delays
  static const Duration staggerDelay = Duration(milliseconds: 50);
  static const Duration staggerDelayLong = Duration(milliseconds: 100);

  // Animation curves
  static const Curve slideInCurve = Curves.easeOutCubic;
  static const Curve slideOutCurve = Curves.easeInCubic;
  static const Curve bounceInCurve = Curves.elasticOut;
  static const Curve scaleInCurve = Curves.easeOutBack;

  // Offset constants for slide animations
  static const Offset slideInFromLeft = Offset(-1.0, 0.0);
  static const Offset slideInFromRight = Offset(1.0, 0.0);
  static const Offset slideInFromTop = Offset(0.0, -1.0);
  static const Offset slideInFromBottom = Offset(0.0, 1.0);
}

class AnimationHelpers {
  static Widget slideInFromLeft({
    required Widget child,
    Duration? duration,
    Duration? delay,
  }) {
    return TweenAnimationBuilder<Offset>(
      tween: Tween<Offset>(
        begin: const Offset(-50, 0),
        end: Offset.zero,
      ),
      duration: duration ?? AnimationConstants.normalAnimation,
      curve: AnimationConstants.slideInCurve,
      builder: (context, offset, child) {
        return Transform.translate(
          offset: offset,
          child: child,
        );
      },
      child: child,
    );
  }

  static Widget slideInFromRight({
    required Widget child,
    Duration? duration,
    Duration? delay,
  }) {
    return TweenAnimationBuilder<Offset>(
      tween: Tween<Offset>(
        begin: const Offset(50, 0),
        end: Offset.zero,
      ),
      duration: duration ?? AnimationConstants.normalAnimation,
      curve: AnimationConstants.slideInCurve,
      builder: (context, offset, child) {
        return Transform.translate(
          offset: offset,
          child: child,
        );
      },
      child: child,
    );
  }

  static Widget fadeInUp({
    required Widget child,
    Duration? duration,
    Duration? delay,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: duration ?? AnimationConstants.normalAnimation,
      curve: AnimationConstants.slideInCurve,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: child,
    );
  }

  static Widget bounceIn({
    required Widget child,
    Duration? duration,
    Duration? delay,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: duration ?? AnimationConstants.extraSlowAnimation,
      curve: AnimationConstants.bounceInCurve,
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.3 + (0.7 * value),
          child: child,
        );
      },
      child: child,
    );
  }
}