import 'package:flutter/material.dart';
import 'package:vegan_reviews/shared/shared.dart';

class FilterDrawer extends StatelessWidget {
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
            )
          ],
        ),
      ),
    );
  }
}