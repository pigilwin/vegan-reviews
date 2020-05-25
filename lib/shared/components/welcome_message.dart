import 'package:flutter/material.dart';

class WelcomeMessage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final String message = _getMessage();
    return Text(message, style: const TextStyle(color: Colors.white, fontSize: 20));
  }

  String _getMessage() {
    final DateTime dateTime = DateTime.now().toLocal();
    if (dateTime.hour < 12) {
      return "Good Morning";
    }
    if (dateTime.hour > 12 && dateTime.hour < 7) {
      return "Good Afternoon";
    }
    return "Good Evening";
  }
}