import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegan_reviews/reviews/reviews.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  
  final PageController controller = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Search"),
      ),
      body: BlocBuilder<ReviewsBloc, ReviewsState>(
        builder: (BuildContext context, ReviewsState state) {
          return PageView(
            controller: controller,
            children: buildChildren(state),
          );
        },
      ),
    );
  }

  List<Widget> buildChildren(ReviewsState state) {
    if (state is LoadedReviews){
      final List<Widget> children = [];
      for (Review review in state.reviews) {
        children.add(SingleChildScrollView(
          child: ReviewOverviewCard(
            onTap: (Review review) {
              Navigator.of(context).pushNamed('/review', arguments: review.id);
            },
            review: review,
          ),
        ));
      }
      return children;
    }
    return [];
  }
}