import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

class Review {

  const Review({
    this.id,
    this.name,
    this.description,
    this.image,
    this.stars,
    this.worthIt,
    this.price,
    this.supplier,
    this.limited
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
      limited: false
    );
  }

  final String id;
  final String name;
  final String description;
  final io.File image;
  final int stars;
  final bool worthIt;
  final double price;
  final String supplier;
  final bool limited;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'stars': stars,
      'price': price,
      'worthIt': _boolToInt(worthIt),
      'limited': _boolToInt(limited),
      'supplier': supplier,
      'image-name': basename(image.path)
    };
  }

  int _boolToInt(bool value) {
    if (value) {
      return 1;
    }
    return 0;
  }
}