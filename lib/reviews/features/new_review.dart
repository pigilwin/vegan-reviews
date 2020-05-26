import 'package:flutter/material.dart';
import 'package:vegan_reviews/reviews/reviews.dart';

class NewReview extends StatefulWidget {

  @override
  _NewReviewState createState() => _NewReviewState();
}

class _NewReviewState extends State<NewReview> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create a new review"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ReviewEditor(
            review: Review.empty(),
          ),
        ),
      ),
    );
  }
}