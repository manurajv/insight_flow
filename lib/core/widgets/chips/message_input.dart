import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/glassmorphism_effects.dart';

class MessageInput extends StatelessWidget {
  const MessageInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      borderRadius: 12,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                style: GlassTextStyle.body,
                decoration: InputDecoration(
                  hintText: 'Ask about your data...',
                  hintStyle: GlassTextStyle.body.copyWith(color: Colors.white70),
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send, color: AppColors.primary),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}