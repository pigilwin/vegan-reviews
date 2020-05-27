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
    return FlatButton(
      color: Theme.of(context).primaryColor,
      child: Text(buttonText, style: const TextStyle(fontSize: 20)),
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
    );
  }
}