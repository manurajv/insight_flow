import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../utils/glassmorphism_effects.dart';

class DashboardCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;

  const DashboardCard({
    required this.child,
    this.padding,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GlassContainer(
        borderRadius: 12,
        child: Padding(
          padding: padding ?? const EdgeInsets.all(16.0),
          child: child,
        ),
      ),
    );
  }
}