import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../utils/glassmorphism_effects.dart';

class GlassButton extends StatelessWidget {
  final String? text;
  final Widget? child;
  final VoidCallback? onPressed;
  final double width;
  final double height;
  final bool isActive;

  const GlassButton({
    this.text,
    this.child,
    required this.onPressed,
    this.width = 120,
    this.height = 50,
    this.isActive = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    assert(text != null || child != null, 'Either text or child must be provided');

    return GestureDetector(
      onTap: onPressed,
      child: GlassContainer(
        width: width,
        height: height,
        color: isActive
            ? AppColors.primary.withOpacity(0.3)
            : AppColors.surface,
        child: Center(
          child: child ?? Text(
            text!,
            style: GlassTextStyle.body.copyWith(
              fontWeight: FontWeight.w600,
              color: isActive ? Colors.white : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}