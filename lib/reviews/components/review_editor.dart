import 'package:flutter/material.dart';
import 'package:vegan_reviews/reviews/reviews.dart';

class ReviewEditor extends StatefulWidget{

  const ReviewEditor({
    @required this.review
  });

  final Review review;

  @override
  _ReviewEditorState createState() => _ReviewEditorState();
}

class _ReviewEditorState extends State<ReviewEditor> {
  
  @override
  Widget build(BuildContext context) {
    return Column();
  }
}