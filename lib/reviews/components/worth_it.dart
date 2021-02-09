import 'package:flutter/material.dart';
import 'package:vegan_reviews/reviews/reviews.dart';

class WorthIt extends StatelessWidget {
  
  const WorthIt({
    @required this.review
  });

  final Review review;

  static const Map<String, List<int>> emojis = {
    '🤢': [0, 1, 2],
    '😞': [3, 4],
    '😑': [5, 6],
    '😊': [7, 8],
    '😍': [9, 10]
  };

  @override
  Widget build(BuildContext context) {
    
    var emoji = '';
    emojis.forEach((String face, List<int> value) { 
      if (value.contains(review.stars)){
        emoji = face;
      }
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