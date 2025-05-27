import 'package:flutter/material.dart';

import '../widgets/charts/bar_chart.dart';
import '../widgets/charts/line_chart.dart';

class AIService {
  Future<String> generateResponse(String prompt, {List<Map<String, dynamic>>? context}) async {
    // TODO: Connect to real AI API later
    await Future.delayed(const Duration(seconds: 1)); // Simulate API call

    // Mock responses based on query
    if (prompt.toLowerCase().contains('sales')) {
      return 'Sales last quarter: \$125K (↑12% from previous quarter)';
    } else if (prompt.toLowerCase().contains('revenue')) {
      return 'Revenue breakdown:\n- Product A: \$65K\n- Product B: \$42K\n- Product C: \$18K';
    }
    return 'I analyzed your data and found meaningful insights about "$prompt"';
  }

  Future<Widget?> generateVisualization(String prompt) async {
    // TODO: Connect to real visualization generator
    await Future.delayed(const Duration(milliseconds: 800));

    if (prompt.toLowerCase().contains('trend')) {
      return const LineChartSample(); // Your existing chart
    } else if (prompt.toLowerCase().contains('compare')) {
      return const BarChartSample();
    }
    return null;
  }
}