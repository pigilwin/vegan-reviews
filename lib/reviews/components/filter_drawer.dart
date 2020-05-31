import 'package:flutter/material.dart';
import 'package:vegan_reviews/reviews/reviews.dart';
import 'package:vegan_reviews/shared/shared.dart';

class FilterDrawer extends StatefulWidget {
  @override
  _FilterDrawerState createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  
  bool limitedTime;
  String foodType;
  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: VeganGradient.gradient(0.2)
        ),
        child: ListView(
          children: [
            const DrawerHeader(
              child: Text("Filter Reviews", style: TextStyle(fontSize: 22)),
            ),
            SwitchListTile(
              onChanged: (bool changed) {
                setState(() {
                  limitedTime = changed;
                });
              },
              value: false,
              title: const Text("Limited time items only"),
            ),
            FoodTypeSelector(
              selected: (String type){
                setState(() {
                  foodType = type;
                });
              },
              value: null,
            )
          ],
        ),
      ),
    );
  }
}