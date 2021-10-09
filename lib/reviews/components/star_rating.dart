import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  
  const StarRating({
    required Key key,
    required this.canBeEditted,
    required this.onRatingChanged,
    required this.rating,
    required this.stars,
    required this.size
  }): super(key: key);

  final int stars;
  final int? rating;
  final void Function(int rating)? onRatingChanged;
  final bool canBeEditted;
  final double size;
  
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Wrap(
        alignment: WrapAlignment.start,
        spacing: 0.0,
        children: List.generate(stars, (int index) => _buildStar(context, index)),
      ),
    );
  }

  Widget _buildStar(BuildContext context, int index) {
    
    if (!canBeEditted) {
      return _buildIcon(context, index);
    }
    
    return GestureDetector(
      onTap: () {
        onRatingChanged!(index + 1);
      },
      onHorizontalDragUpdate: (DragUpdateDetails updateDetails) {
        final renderBox = context.findRenderObject() as RenderBox;
        final offset = renderBox.globalToLocal(updateDetails.globalPosition);
        var i = offset.dx ~/ size.toInt();
        if (i > stars) {
          i = stars;
        }
        if (i < 0) {
          i = 0;
        }
        onRatingChanged!(i);
      },
      child: _buildIcon(context, index),
    );
  }

  Widget _buildIcon(BuildContext context, int index) {
    final color = Theme.of(context).primaryColor;
    
    if (index >= rating!) {
      return Icon(Icons.star_border,
        color: color,
        size: size,
      );
    }
    
    return Icon(Icons.star,
      color: color,
      size: size,
    );
  }
}