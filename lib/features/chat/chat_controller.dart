import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/models/message_model.dart';
import '../../../core/services/ai_service.dart';
import '../../../core/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatController with ChangeNotifier {
  final AIService _aiService = AIService();
  final FirestoreService _firestoreService = FirestoreService();
  final List<Message> _messages = [];
  List<Map<String, dynamic>> _conversationContext = [];
  bool _isLoading = false;
  String? _currentChatId;

  List<Message> get messages => _messages;
  bool get isLoading => _isLoading;
  String? get currentChatId => _currentChatId;

  // Get all chats for the current user
  Stream<List<Map<String, dynamic>>> getUserChats() {
    return _firestoreService.getUserChats();
  }

  // Start a new chat
  Future<void> startNewChat() async {
    _currentChatId = await _firestoreService.createNewChat();
    _messages.clear();
    _conversationContext.clear();
    notifyListeners();
  }

  // Load an existing chat
  Future<void> loadChat(String chatId) async {
    _currentChatId = chatId;
    _messages.clear();
    _conversationContext.clear();
    
    // Listen to messages stream
    _firestoreService.getChatMessages(chatId).listen((messages) {
      _messages.clear();
      _messages.addAll(messages);
      notifyListeners();
    });
  }

  // Delete a chat
  Future<void> deleteChat(String chatId) async {
    await _firestoreService.deleteChat(chatId);
    if (_currentChatId == chatId) {
      _currentChatId = null;
      _messages.clear();
      _conversationContext.clear();
      notifyListeners();
    }
  }

  Future<void> sendMessage(String text) async {
    if (_currentChatId == null) {
      await startNewChat();
    }

    // Save user message
    final userMessage = Message(text: text, isUser: true);
    _addUserMessage(userMessage);
    await _firestoreService.saveMessage(_currentChatId!, userMessage);

    _setLoading(true);

    try {
      // Get AI response
      final response = await _aiService.generateResponse(
        text,
        context: _conversationContext,
      );
      final visualization = await _aiService.generateVisualization(text);

      // Update context
      _updateContext(userMessage: text, aiResponse: response);

      // Save AI message
      final aiMessage = Message(text: response, isUser: false, chart: visualization);
      _addAiMessage(aiMessage);
      await _firestoreService.saveMessage(_currentChatId!, aiMessage);

    } catch (e) {
      final errorMessage = Message(
        text: "Sorry, I encountered an error. Please try again.",
        isUser: false,
      );
      _addAiMessage(errorMessage);
      await _firestoreService.saveMessage(_currentChatId!, errorMessage);
    } finally {
      _setLoading(false);
    }
  }

  void _addUserMessage(Message message) {
    _messages.add(message);
    notifyListeners();
  }

  void _addAiMessage(Message message) {
    _messages.add(message);
    notifyListeners();
  }

  void _updateContext({required String userMessage, required String aiResponse}) {
    _conversationContext.add({
      'user': userMessage,
      'ai': aiResponse,
      'timestamp': DateTime.now().toString(),
    });

    // Keep only last 5 messages for context
    if (_conversationContext.length > 5) {
      _conversationContext.removeAt(0);
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void clearMessages() {
    _messages.clear();
    _conversationContext.clear();
    notifyListeners();
  }

  Future<String> createNewChat() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) throw Exception('User not authenticated');
    final docRef = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('chats')
        .add({
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
    return docRef.id;
  }

  Future<void> saveMessage(String chatId, Message message) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) throw Exception('User not authenticated');
    final chatRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('chats')
        .doc(chatId);
    await chatRef.collection('messages').add({
      'text': message.text,
      'isUser': message.isUser,
      'timestamp': FieldValue.serverTimestamp(),
      'chartType': message.chartType,
      'chartData': message.chartData,
    });
    await chatRef.update({'updatedAt': FieldValue.serverTimestamp()});
  }
}