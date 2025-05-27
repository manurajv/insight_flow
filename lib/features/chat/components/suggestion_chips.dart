import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/widgets/buttons/glass_button.dart';
import '../chat_controller.dart';

class SuggestionChips extends StatelessWidget {
  const SuggestionChips({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final suggestions = [
      'Show sales trends',
      'Compare revenue by product',
      'Display customer demographics',
      'Create a dashboard',
    ];

    return SizedBox(
      height: 50,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        scrollDirection: Axis.horizontal,
        itemCount: suggestions.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          return GlassButton(
            text: suggestions[index],
            onPressed: () {
              Provider.of<ChatController>(context, listen: false)
                  .sendMessage(suggestions[index]);
            },
          );
        },
      ),
    );
  }
}