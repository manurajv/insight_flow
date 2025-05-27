import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String text;
  final bool isUser;
  final Widget? chart;
  final String? chartType;
  final Map<String, dynamic>? chartData;

  Message({
    required this.text,
    required this.isUser,
    this.chart,
    this.chartType,
    this.chartData,
  });

  factory Message.fromFirestore(Map<String, dynamic> data) {
    return Message(
      text: data['text'] ?? '',
      isUser: data['isUser'] ?? false,
      chartType: data['chartType'],
      chartData: data['chartData'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'text': text,
      'isUser': isUser,
      'chartType': chartType,
      'chartData': chartData,
    };
  }
}

Future<void> deleteChat(String chatId) async {
  final userId = FirebaseAuth.instance.currentUser?.uid;
  if (userId == null) throw Exception('User not authenticated');
  final chatRef = FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .collection('chats')
      .doc(chatId);

  // Delete all messages in the chat
  final messages = await chatRef.collection('messages').get();
  for (var doc in messages.docs) {
    await doc.reference.delete();
  }

  // Delete the chat document
  await chatRef.delete();
}