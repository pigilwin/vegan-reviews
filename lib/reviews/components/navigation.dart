import 'package:flutter/material.dart';

class Navigation extends StatefulWidget {
  const Navigation({
    required Key key,
    this.controller
  }): super(key: key);

  final PageController? controller;

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {

  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.controller!.initialPage;
  }

  @override
  Widget build(BuildContext context) {    
    final items = <BottomNavigationBarItem>[];

    items.add(const BottomNavigationBarItem(
      label: 'Home',
      icon: Icon(Icons.home)
    ));

    items.add(const BottomNavigationBarItem(
      label: 'Saved',
      icon: Icon(Icons.layers_rounded)
    ));

    items.add(const BottomNavigationBarItem(
      label: 'About',
      icon: Icon(Icons.info)
    ));
    
    
    return BottomNavigationBar(
      items: items,
      currentIndex: _selectedIndex,
      onTap: (int i) {
        widget.controller!.animateToPage(i, duration: const Duration(milliseconds: 2), curve: Curves.bounceInOut);
        setState(() {
          _selectedIndex = i;
        });
      },
    );
  }
}