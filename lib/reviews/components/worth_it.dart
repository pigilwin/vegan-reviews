import 'package:flutter/material.dart';
import 'package:vegan_reviews/reviews/reviews.dart';

class WorthIt extends StatelessWidget {
  
  static const Map<String, List<int>> emojis = {
    '🤢': [0, 1, 2],
    '😞': [3, 4],
    '😑': [5, 6],
    '😊': [7, 8],
    '😍': [9, 10]
  };


  const WorthIt({
    @required this.review
  });

  final Review review;

  @override
  Widget build(BuildContext context) {
    final emoji = emojis.keys.firstWhere((String key) {
      return emojis[key].contains(review.stars);
    }, orElse: () {
      return '';
    });

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Tooltip(
        message: 'Worth it',
        child: Text(emoji, style: const TextStyle(fontSize: 20)),
      ),
    );
  }
}