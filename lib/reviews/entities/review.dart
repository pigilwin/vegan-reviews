import 'dart:io' as io;
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class Review {

  const Review({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.created,
    @required this.stars,
    @required this.price,
    @required this.supplier,
    @required this.limited,
    @required this.type,
    this.image,
    this.imageUrl
  });

  factory Review.empty() {
    return Review(
      id: Uuid().v4(),
      name: '',
      description: '',
      image: null,
      imageUrl: '',
      stars: 0,
      price: 0,
      supplier: '',
      limited: false,
      type: 'Savoury',
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
  final int stars;
  final double price;
  final String supplier;
  final bool limited;
  final String type;
  final DateTime created;

  final io.File image;
  final String imageUrl;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'stars': stars,
      'price': price,
      'limited': _boolToInt(limited),
      'supplier': supplier,
      'type': type,
      'created': created.toIso8601String()
    };
  }

  String get imageName => "${id}.jpg";

  int _boolToInt(bool value) {
    if (value) {
      return 1;
    }
    return 0;
  }
}