import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  
  const Button({
    required this.buttonText,
    required this.onPressed,
    required Key key
  }): super(key: key);

  final String buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(5)
        ),
        padding: const EdgeInsets.all(8),
        child: Text(buttonText, style: const TextStyle(fontSize: 20, color: Colors.white)),
      ),
    );
  }
}