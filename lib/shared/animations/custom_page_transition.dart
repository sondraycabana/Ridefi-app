import 'package:flutter/material.dart';

class CustomPageTransition extends PageRouteBuilder {
  final Widget child;
  final Color? fromColor;
  final Color? toColor;
  final Duration duration;

  CustomPageTransition({
    required this.child,
    this.fromColor,
    this.toColor,
    this.duration = const Duration(milliseconds: 800),
  }) : super(
          transitionDuration: duration,
          reverseTransitionDuration: duration,
          pageBuilder: (context, animation, secondaryAnimation) => child,
        );

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return Stack(
      children: [
        // Animated background color transition
        AnimatedBuilder(
          animation: animation,
          builder: (context, _) {
            return Container(
              color: ColorTween(
                begin: fromColor,
                end: toColor,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut,
              )).value,
            );
          },
        ),
        
        // Slide transition for the new page
        SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
          )),
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        ),
        
        // Slide out the previous page elements
        if (secondaryAnimation.value > 0)
          SlideTransition(
            position: Tween<Offset>(
              begin: Offset.zero,
              end: const Offset(-0.3, 0.0),
            ).animate(CurvedAnimation(
              parent: secondaryAnimation,
              curve: Curves.easeInCubic,
            )),
            child: FadeTransition(
              opacity: Tween<double>(
                begin: 1.0,
                end: 0.0,
              ).animate(CurvedAnimation(
                parent: secondaryAnimation,
                curve: Curves.easeInCubic,
              )),
              child: Container(), // This will be the previous page content
            ),
          ),
      ],
    );
  }
}

class SlideUpPageTransition extends PageRouteBuilder {
  final Widget child;
  final Color? backgroundColor;

  SlideUpPageTransition({
    required this.child,
    this.backgroundColor,
  }) : super(
          transitionDuration: const Duration(milliseconds: 600),
          reverseTransitionDuration: const Duration(milliseconds: 600),
          pageBuilder: (context, animation, secondaryAnimation) => child,
        );

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return Stack(
      children: [
        // Background color
        if (backgroundColor != null)
          Container(color: backgroundColor),
        
        // Slide up animation with elastic curve
        SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 1.0),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.elasticOut,
          )),
          child: ScaleTransition(
            scale: Tween<double>(
              begin: 0.8,
              end: 1.0,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutBack,
            )),
            child: child,
          ),
        ),
      ],
    );
  }
}

class ScalePageTransition extends PageRouteBuilder {
  final Widget child;
  final Alignment alignment;

  ScalePageTransition({
    required this.child,
    this.alignment = Alignment.center,
  }) : super(
          transitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (context, animation, secondaryAnimation) => child,
        );

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return ScaleTransition(
      alignment: alignment,
      scale: CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutQuart,
      ),
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }
}