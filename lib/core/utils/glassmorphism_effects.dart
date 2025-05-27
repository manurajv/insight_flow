import 'dart:ui';

import 'package:flutter/material.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final double borderRadius;
  final double blur;
  final Color color;

  const GlassContainer({
    required this.child,
    this.width,
    this.height,
    this.borderRadius = 16.0,
    this.blur = 5.0,
    this.color = const Color(0x15FFFFFF),
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: Colors.white.withOpacity(0.2),
            width: 1.0,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: child,
        ),
      ),
    );
  }
}

class GlassTextStyle {
  static TextStyle headline = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    shadows: [
      Shadow(
        blurRadius: 10.0,
        color: Colors.black.withOpacity(0.3),
        offset: Offset(2.0, 2.0),
      ),
    ],
  );

  static TextStyle body = TextStyle(
    fontSize: 16,
    color: Colors.white.withOpacity(0.9),
  );
}