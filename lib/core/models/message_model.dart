import 'package:flutter/material.dart';

class Message {
  final String text;
  final bool isUser;
  final Widget? chart;

  Message({
    required this.text,
    required this.isUser,
    this.chart,
  });
}