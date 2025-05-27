import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../utils/glassmorphism_effects.dart';

class GlassInputField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final IconData? icon;
  final bool obscureText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const GlassInputField({
    this.controller,
    this.labelText,
    this.icon,
    this.obscureText = false,
    this.validator,
    this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: validator,
        onChanged: onChanged,
        style: GlassTextStyle.body,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: GlassTextStyle.body.copyWith(color: Colors.white70),
          prefixIcon: icon != null
              ? Icon(icon, color: Colors.white70)
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
        cursorColor: AppColors.secondary,
      ),
    );
  }
}