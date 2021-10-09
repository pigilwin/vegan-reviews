import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({required Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: const [
          Text('About Jody\'s Vegan Reviews')
        ],
      ),
    );
  }
}