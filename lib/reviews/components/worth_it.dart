import 'package:flutter/material.dart';

class WorthIt extends StatelessWidget {
  
  const WorthIt({
    @required this.worthIt
  });

  final bool worthIt;

  @override
  Widget build(BuildContext context) {
    if (worthIt) {
      return const Padding(
        padding: EdgeInsets.all(10),
        child: Tooltip(
          message: 'Worth it',
          child: Text("😍", style: TextStyle(fontSize: 20)),
        ),
      );
    }
    return const Padding(
      padding: EdgeInsets.all(10),
      child: Tooltip(
        message: 'Not worth it',
        child: Text("🤢", style: TextStyle(fontSize: 20)),
      ),
    );
  }
}