import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegan_reviews/reviews/reviews.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  
  final PageController controller = PageController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: _getAppBar(context),
      body: BlocBuilder<ReviewsBloc, ReviewsState>(
        builder: (BuildContext context, ReviewsState state) {
          return PageView(
            controller: controller,
            children: buildChildren(state),
          );
        },
      ),
      endDrawer: FilterDrawer(),
    );
  }

  List<Widget> buildChildren(ReviewsState state) {
    final List<Widget> children = [];
    for (Review review in state.filteredReviews) {
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

  AppBar _getAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Text("Search"),
      actions: [
        IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            scaffoldKey.currentState.openEndDrawer();
          },
        )
      ],
    );
  }
}