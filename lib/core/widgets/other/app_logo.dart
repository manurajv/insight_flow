import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class AppLogo extends StatelessWidget {
  final double size;

  const AppLogo({this.size = 40, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(
          Icons.auto_awesome,
          color: Colors.white,
          size: size * 0.6,
        ),
      ),
    );
  }
}