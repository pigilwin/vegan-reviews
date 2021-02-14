import 'package:flutter/material.dart';

class Navigation extends StatefulWidget {
  const Navigation();

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {    
    final items = <BottomNavigationBarItem>[];

    items.add(BottomNavigationBarItem(
      label: 'Home',
      icon: Icon(Icons.home)
    ));

    items.add(BottomNavigationBarItem(
      label: 'Saved',
      icon: Icon(Icons.layers_rounded)
    ));

    items.add(BottomNavigationBarItem(
      label: 'About',
      icon: Icon(Icons.info)
    ));
    
    
    return BottomNavigationBar(
      items: items,
      currentIndex: currentIndex,
    );
  }
}