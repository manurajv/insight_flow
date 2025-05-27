import 'package:flutter/material.dart';
import '../../../core/models/message_model.dart';
import '../../../core/services/ai_service.dart';

class ChatController with ChangeNotifier {
  final AIService _aiService = AIService();
  final List<Message> _messages = [];
  List<Map<String, dynamic>> _conversationContext = [];
  bool _isLoading = false;

  List<Message> get messages => _messages;
  bool get isLoading => _isLoading;

  Future<void> sendMessage(String text) async {
    // Add user message
    _addUserMessage(text);
    _setLoading(true);

    try {
      // Get AI response
      final response = await _aiService.generateResponse(
          text,
          context: _conversationContext
      );
      final visualization = await _aiService.generateVisualization(text);

      // Update context
      _updateContext(userMessage: text, aiResponse: response);

      // Add AI message
      _addAiMessage(response, visualization);
    } catch (e) {
      _addAiMessage("Sorry, I encountered an error. Please try again.", null);
    } finally {
      _setLoading(false);
    }
  }

  void _addUserMessage(String text) {
    _messages.add(Message(text: text, isUser: true));
    notifyListeners();
  }

  void _addAiMessage(String text, Widget? chart) {
    _messages.add(Message(text: text, isUser: false, chart: chart));
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
}