import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/buttons/glass_button.dart';

class SuggestionChips extends StatelessWidget {
  const SuggestionChips({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        children: [
          GlassButton(
            onPressed: () {},
            text: 'Show sales data',
          ),
          const SizedBox(width: 8),
          GlassButton(
            onPressed: () {},
            text: 'Revenue trends',
          ),
          const SizedBox(width: 8),
          GlassButton(
            onPressed: () {},
            text: 'Create dashboard',
          ),
        ],
      ),
    );
  }
}