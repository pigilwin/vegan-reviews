import 'package:flutter/material.dart';
import 'package:vegan_reviews/reviews/reviews.dart';

class StarAmountChooser extends StatelessWidget {
  
  const StarAmountChooser({
    required Key key,
    required this.value,
    required this.selected
  }): super(key: key);

  final int value;
  final void Function(int? value) selected;
  
  @override
  Widget build(Object context) {
    return DropdownButtonFormField<int>(
      decoration: const InputDecoration(
        labelText: 'Amount of stars'
      ),
      value: value,
      onChanged: selected,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      items: List<int>.generate(Review.amountOfStars + 1, (int index) => index).map<DropdownMenuItem<int>>((int value) {
        return DropdownMenuItem<int>(
          value: value,
          child: Text(value.toString()),
        );
      }).toList(),
    );
  }
}