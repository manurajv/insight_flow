import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/utils/glassmorphism_effects.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isUser;
  final Widget? chart;

  const ChatBubble({
    required this.message,
    this.isUser = false,
    this.chart,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
        isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUser)
            Container(
              margin: const EdgeInsets.only(right: 8),
              child: CircleAvatar(
                backgroundColor: AppColors.primary,
                child: Icon(Icons.auto_awesome, color: Colors.white),
              ),
            ),
          Flexible(
            child: Column(
              crossAxisAlignment:
              isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                GlassContainer(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      message,
                      style: GlassTextStyle.body,
                    ),
                  ),
                ),
                if (chart != null) ...[
                  const SizedBox(height: 8),
                  GlassContainer(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: chart!,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}