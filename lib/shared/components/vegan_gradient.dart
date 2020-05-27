import 'package:flutter/material.dart';

class VeganGradient {
  
  static LinearGradient gradient(double opacity) {
    return LinearGradient(
      colors: [
        const Color(0xFF76BA1B).withOpacity(opacity),
        const Color(0xFF4C9A2A).withOpacity(opacity)
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight
    );
  }
}