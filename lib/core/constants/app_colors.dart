import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF6C5CE7);
  static const Color secondary = Color(0xFF00CEFF);
  static const Color background = Color(0xFF1E1E2D);
  static const Color surface = Color(0x20FFFFFF);
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFFB2B2B2);
  static const Color success = Color(0xFF00E676);
  static const Color error = Color(0xFFFF5252);
  static const Color warning = Color(0xFFFFD740);

  static LinearGradient primaryGradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}