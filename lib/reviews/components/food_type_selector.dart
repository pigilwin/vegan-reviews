import 'package:flutter/material.dart';
import 'package:vegan_reviews/reviews/reviews.dart';

class FoodTypeSelector extends StatelessWidget {
  
  const FoodTypeSelector({
    @required this.value,
    @required this.selected,
    @required this.validator
  });

  final String value;
  final void Function(String value) selected;
  final String Function(String value) validator;
  
  @override
  Widget build(Object context) {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        labelText: 'Food Type'
      ),
      value: value,
      onChanged: selected,
      icon: const Icon(Icons.arrow_downward),
      validator: validator,
      iconSize: 24,
      elevation: 16,
      items: Review.types.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}