import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  
  const Button({
    @required this.buttonText,
    @required this.onPressed
  });

  final String buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(5)
        ),
        padding: EdgeInsets.all(8),
        child: Text(buttonText, style: const TextStyle(fontSize: 20, color: Colors.white)),
      ),
      onPressed: onPressed
    );
  }
}