import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/glassmorphism_effects.dart';
import '../../../core/widgets/buttons/glass_button.dart';
import '../chat_controller.dart';
import '../components/chat_bubble.dart';
import '../components/message_input.dart';
import '../components/suggestion_chips.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topRight,
                radius: 1.5,
                colors: [
                  AppColors.primary.withOpacity(0.2),
                  AppColors.background,
                ],
              ),
            ),
          ),
          // Content
          Column(
            children: [
              // Header
              GlassContainer(
                //margin: const EdgeInsets.all(8),
                borderRadius: 12,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12),
                  child: Row(
                    children: [
                      const Icon(Icons.auto_awesome, color: Colors.white),
                      const SizedBox(width: 8),
                      Text(
                        'AI Dashboard Assistant',
                        style: GlassTextStyle.headline.copyWith(fontSize: 18),
                      ),
                      const Spacer(),
                      GlassButton(
                        onPressed: () =>
                            Provider.of<ChatController>(context, listen: false)
                                .clearMessages(),
                        child: Text('New Chat', style: GlassTextStyle.body),
                      ),
                    ],
                  ),
                ),
              ),
              // Chat messages
              Expanded(
                child: Consumer<ChatController>(
                  builder: (context, controller, _) {
                    _scrollToBottom();
                    return Stack(
                      children: [
                        ListView.builder(
                          controller: _scrollController,
                          padding: const EdgeInsets.all(8),
                          itemCount: controller.messages.length,
                          itemBuilder: (context, index) {
                            final message = controller.messages[index];
                            return ChatBubble(
                              message: message.text,
                              isUser: message.isUser,
                              chart: message.chart,
                            );
                          },
                        ),
                        if (controller.isLoading)
                          const Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: SpinKitThreeBounce(
                                color: AppColors.primary,
                                size: 20.0,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
              // Suggestions
              const SuggestionChips(),
              // Message input
              const MessageInput(),
            ],
          ),
        ],
      ),
    );
  }
}