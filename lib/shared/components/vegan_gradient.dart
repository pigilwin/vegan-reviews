import 'package:flutter/material.dart';

class VeganGradient {
  
  static LinearGradient get gradient {
    return LinearGradient(
      colors: [
        const Color(0xFF76BA1B).withOpacity(0.2),
        const Color(0xFF4C9A2A).withOpacity(0.2)
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight
    );
  }
}