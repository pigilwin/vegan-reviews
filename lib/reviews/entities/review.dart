import 'dart:io' as io;
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

class Review {

  const Review({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.created,
    @required this.image,
    @required this.stars,
    @required this.worthIt,
    @required this.price,
    @required this.supplier,
    @required this.limited,
    @required this.type
  });

  factory Review.empty() {
    return Review(
      id: Uuid().v4(),
      name: '',
      description: '',
      image: null,
      stars: 0,
      worthIt: false,
      price: 0,
      supplier: '',
      limited: false,
      type: 'savoury',
      created: DateTime.now()
    );
  }

  static const List<String> types = [
    'Savoury',
    'Sweet'
  ];

  final String id;
  final String name;
  final String description;
  final io.File image;
  final int stars;
  final bool worthIt;
  final double price;
  final String supplier;
  final bool limited;
  final String type;
  final DateTime created;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'stars': stars,
      'price': price,
      'worthIt': _boolToInt(worthIt),
      'limited': _boolToInt(limited),
      'supplier': supplier,
      'type': type,
      'image-name': imageName,
      'created': created.toIso8601String()
    };
  }

  String get imageName => basename(image.path);

  int _boolToInt(bool value) {
    if (value) {
      return 1;
    }
    return 0;
  }
}