import 'package:flutter/material.dart';
import 'package:vegan_reviews/shared/shared.dart';

class Bottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BottomClipper(),
      child: Container(
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: VeganGradient.gradient(1.0)
        ),
      ),
    );
  }
}

class BottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0.0, 20);

    final Offset firstControlPoint = Offset(size.width / 4, 0.0);
    final Offset firstEndPoint = Offset(size.width / 2.25, 30.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);

    final Offset secondControlPoint = Offset(size.width - (size.width / 3.25), 65);
    final Offset secondEndPoint = Offset(size.width, 40);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}