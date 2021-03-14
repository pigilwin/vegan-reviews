import 'package:flutter/material.dart';
import 'package:vegan_reviews/reviews/reviews.dart';

class FoodTypeSelector extends StatelessWidget {
  
  const FoodTypeSelector({
    required this.value,
    required this.selected
  });

  final String value;
  final void Function(String value) selected;
  
  @override
  Widget build(Object context) {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        labelText: 'Food Type'
      ),
      value: value,
      onChanged: (String? value) {
        selected(value!);
      },
      icon: const Icon(Icons.arrow_downward),
      validator: (String? value) {
        if (value == 'None Selected'){
          return 'A value must be selected';
        }
        return null;
      },
      iconSize: 24,
      elevation: 16,
      items: _getItems(),
    );
  }

  List<DropdownMenuItem<String>> _getItems() {
    final items = <DropdownMenuItem<String>>[];
    Review.types.forEach((String key, String value) { 
      items.add(DropdownMenuItem(
        value: key,
        child: Text(value),
      ));
    });
    return items;
  }
}