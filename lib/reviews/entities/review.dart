import 'package:uuid/uuid.dart';

class Review {

  const Review({
    this.id,
    this.name,
    this.description,
    this.imagePath,
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
      imagePath: '',
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
  final String imagePath;
  final int stars;
  final bool worthIt;
  final double price;
  final String supplier;
  final bool limited;
}