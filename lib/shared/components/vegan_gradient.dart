import 'package:flutter/material.dart';

class VeganGradient extends LinearGradient{
  
  const VeganGradient(): super(
    colors: const [
      Color(0xFF76BA1B),
      Color(0xFF4C9A2A),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight
  );
}