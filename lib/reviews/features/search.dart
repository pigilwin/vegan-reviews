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
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Search for a review"),
      ),
      body: BlocBuilder<ReviewsBloc, ReviewsState>(
        builder: (BuildContext builderContext, ReviewsState state) {
          return GridView.count(
            crossAxisCount: 2,
            children: [
              
            ],
          );
        },
      )
    );
  }
}