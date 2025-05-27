import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/glassmorphism_effects.dart';
import '../../../core/widgets/buttons/glass_button.dart';
import '../chat_controller.dart';

class ChatHistoryScreen extends StatelessWidget {
  const ChatHistoryScreen({Key? key}) : super(key: key);

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
                borderRadius: 12,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Chat History',
                        style: GlassTextStyle.headline.copyWith(fontSize: 18),
                      ),
                      const Spacer(),
                      GlassButton(
                        onPressed: () => context.read<ChatController>().startNewChat(),
                        child: Text('New Chat', style: GlassTextStyle.body),
                      ),
                    ],
                  ),
                ),
              ),
              // Chat list
              Expanded(
                child: StreamBuilder<List<Map<String, dynamic>>>(
                  stream: context.read<ChatController>().getUserChats(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'Error loading chats',
                          style: GlassTextStyle.body.copyWith(
                            color: AppColors.error,
                          ),
                        ),
                      );
                    }

                    final chats = snapshot.data ?? [];

                    if (chats.isEmpty) {
                      return Center(
                        child: Text(
                          'No chat history yet',
                          style: GlassTextStyle.body,
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: chats.length,
                      itemBuilder: (context, index) {
                        final chat = chats[index];
                        final updatedAt = chat['updatedAt'];
                        String formattedDate;
                        if (updatedAt is Timestamp) {
                          formattedDate = DateFormat('MMM d, y • h:mm a').format(updatedAt.toDate());
                        } else {
                          formattedDate = '—';
                        }

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: GlassContainer(
                            child: ListTile(
                              onTap: () {
                                context.read<ChatController>().loadChat(chat['id']);
                                Navigator.pop(context); // Return to chat screen
                              },
                              leading: const CircleAvatar(
                                backgroundColor: AppColors.primary,
                                child: Icon(Icons.chat, color: Colors.white),
                              ),
                              title: Text(
                                'Chat ${index + 1}',
                                style: GlassTextStyle.body.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                formattedDate,
                                style: GlassTextStyle.body.copyWith(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete_outline, color: Colors.white70),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      backgroundColor: AppColors.surface,
                                      title: Text(
                                        'Delete Chat',
                                        style: GlassTextStyle.headline.copyWith(fontSize: 20),
                                      ),
                                      content: Text(
                                        'Are you sure you want to delete this chat?',
                                        style: GlassTextStyle.body,
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: Text(
                                            'Cancel',
                                            style: GlassTextStyle.body.copyWith(
                                              color: Colors.white70,
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            context.read<ChatController>().deleteChat(chat['id']);
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            'Delete',
                                            style: GlassTextStyle.body.copyWith(
                                              color: AppColors.error,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}