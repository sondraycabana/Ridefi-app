import 'package:flutter/material.dart';

class AnimatedBackground extends StatefulWidget {
  final Widget child;
  final Color color;
  final Duration duration;
  final List<Color>? gradientColors;
  final AlignmentGeometry gradientBegin;
  final AlignmentGeometry gradientEnd;

  const AnimatedBackground({
    super.key,
    required this.child,
    required this.color,
    this.duration = const Duration(milliseconds: 800),
    this.gradientColors,
    this.gradientBegin = Alignment.topLeft,
    this.gradientEnd = Alignment.bottomRight,
  });

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with TickerProviderStateMixin {
  late AnimationController _colorController;
  late Animation<Color?> _colorAnimation;
  Color? _previousColor;

  @override
  void initState() {
    super.initState();
    _colorController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _previousColor = widget.color;
    _updateColorAnimation();
  }

  void _updateColorAnimation() {
    _colorAnimation = ColorTween(
      begin: _previousColor,
      end: widget.color,
    ).animate(CurvedAnimation(
      parent: _colorController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void didUpdateWidget(AnimatedBackground oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.color != widget.color) {
      _previousColor = oldWidget.color;
      _updateColorAnimation();
      _colorController.reset();
      _colorController.forward();
    }
  }

  @override
  void dispose() {
    _colorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _colorAnimation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: widget.gradientColors != null
                ? LinearGradient(
                    begin: widget.gradientBegin,
                    end: widget.gradientEnd,
                    colors: widget.gradientColors!,
                  )
                : null,
            color: widget.gradientColors == null ? _colorAnimation.value : null,
          ),
          child: widget.child,
        );
      },
    );
  }
}

class MovingIllustrationWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Offset offset;
  final bool animate;

  const MovingIllustrationWidget({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 1200),
    this.offset = const Offset(0, -50),
    this.animate = true,
  });

  @override
  State<MovingIllustrationWidget> createState() => _MovingIllustrationWidgetState();
}

class _MovingIllustrationWidgetState extends State<MovingIllustrationWidget>
    with TickerProviderStateMixin {
  late AnimationController _moveController;
  late Animation<Offset> _moveAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _moveController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _moveAnimation = Tween<Offset>(
      begin: widget.offset,
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _moveController,
      curve: Curves.easeOutBack,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _moveController,
      curve: Curves.easeOut,
    ));

    if (widget.animate) {
      _moveController.forward();
    }
  }

  @override
  void didUpdateWidget(MovingIllustrationWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animate && !oldWidget.animate) {
      _moveController.forward();
    } else if (!widget.animate && oldWidget.animate) {
      _moveController.reverse();
    }
  }

  @override
  void dispose() {
    _moveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _moveController,
      builder: (context, child) {
        return Transform.translate(
          offset: _moveAnimation.value,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: widget.child,
          ),
        );
      },
    );
  }
}

class AnimatedTextWidget extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final Duration duration;
  final Duration delay;
  final bool animate;

  const AnimatedTextWidget({
    super.key,
    required this.text,
    this.style,
    this.duration = const Duration(milliseconds: 800),
    this.delay = Duration.zero,
    this.animate = true,
  });

  @override
  State<AnimatedTextWidget> createState() => _AnimatedTextWidgetState();
}

class _AnimatedTextWidgetState extends State<AnimatedTextWidget>
    with TickerProviderStateMixin {
  late AnimationController _textController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _textController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeOutCubic,
    ));

    if (widget.animate) {
      Future.delayed(widget.delay, () {
        if (mounted) {
          _textController.forward();
        }
      });
    }
  }

  @override
  void didUpdateWidget(AnimatedTextWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animate && !oldWidget.animate) {
      Future.delayed(widget.delay, () {
        if (mounted) {
          _textController.forward();
        }
      });
    } else if (!widget.animate && oldWidget.animate) {
      _textController.reverse();
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _textController,
      builder: (context, child) {
        return SlideTransition(
          position: _slideAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Text(
              widget.text,
              style: widget.style,
            ),
          ),
        );
      },
    );
  }
}