import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Review extends Equatable {

  const Review({
    required this.id,
    required this.name,
    required this.description,
    required this.created,
    required this.stars,
    required this.price,
    required this.supplier,
    required this.limited,
    required this.type,
    required this.imageUrl
  });

  factory Review.empty() {
    return Review(
      id: const Uuid().v4(),
      name: '',
      description: '',
      imageUrl: '',
      stars: 0,
      price: 0,
      supplier: '',
      limited: false,
      type: 'none',
      created: DateTime.now()
    );
  }

  static const Map<String, String> types = {
    'none': 'None Selected',
    'savoury': 'Savoury',
    'sweet': 'Sweet'
  };

  static const Map<String, String> savouryEmojiMap = {
    'savoury': '🍕',
    'sweet': '🍬'
  };

  static const int amountOfStars = 10;

  final String id;
  final String name;
  final String description;
  final int stars;
  final double price;
  final String supplier;
  final bool limited;
  final String type;
  final DateTime created;
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

  String get imageName => '$id.jpg';

  int _boolToInt(bool value) {
    if (value) {
      return 1;
    }
    return 0;
  }

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    stars,
    price,
    supplier,
    limited,
    imageUrl
  ];
}