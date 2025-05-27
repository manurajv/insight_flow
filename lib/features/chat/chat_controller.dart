import 'package:flutter/material.dart';

import '../../core/models/message_model.dart';
import '../../core/widgets/charts/bar_chart.dart';
import '../../core/widgets/charts/line_chart.dart';
import '../../core/widgets/charts/pie_chart.dart';

class ChatController with ChangeNotifier {
  final List<Message> _messages = [];

  List<Message> get messages => _messages;

  void addMessage(Message message) {
    _messages.add(message);
    notifyListeners();
  }

  void clearMessages() {
    _messages.clear();
    notifyListeners();
  }

  Future<void> sendMessage(String text) async {
    // Add user message
    addMessage(Message(text: text, isUser: true));

    // Simulate AI response after delay
    await Future.delayed(const Duration(seconds: 1));

    // Add AI response
    addMessage(Message(
      text: _getAIResponse(text),
      isUser: false,
      chart: _generateChartForQuery(text),
    ));
  }

  String _getAIResponse(String query) {
    if (query.toLowerCase().contains('sales')) {
      return 'Here are the sales trends for the last quarter:';
    } else if (query.toLowerCase().contains('revenue')) {
      return 'Revenue breakdown by product category:';
    } else {
      return 'I analyzed your data and found these insights:';
    }
  }

  Widget? _generateChartForQuery(String query) {
    if (query.toLowerCase().contains('trend')) {
      return const LineChartSample();
    } else if (query.toLowerCase().contains('compare')) {
      return const BarChartSample();
    } else if (query.toLowerCase().contains('breakdown')) {
      return const PieChartSample();
    }
    return null;
  }
}