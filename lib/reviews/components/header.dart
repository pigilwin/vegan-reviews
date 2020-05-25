import 'package:flutter/material.dart';
import 'package:vegan_reviews/shared/shared.dart';

class Header extends StatelessWidget {
  
  const Header({this.onlongPress});

  final void Function() onlongPress;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: HeaderClipper(),
      child: Container(
        height: 250,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFF76BA1B),
              Color(0xFF4C9A2A),
            ],
          )
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                child: Logo(),
                onLongPress: onlongPress,
              ),
              const Divider(height: 40),
              WelcomeMessage()
            ],
          ),
        ),
      ),
    );
  }

}

class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}