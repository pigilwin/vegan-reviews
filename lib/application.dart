import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegan_reviews/authentication/authentication.dart';
import 'package:vegan_reviews/reviews/reviews.dart';

class Application extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: _getProviders(),
      child: MaterialApp(
        title: 'Vegan Reviews',
        theme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        onGenerateRoute: onGenerateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final WidgetBuilder builder = _getRoutes(settings)[settings.name];
    return MaterialPageRoute(
      builder: builder
    );
  }

  Map<String, WidgetBuilder> _getRoutes(RouteSettings settings) {
    return {
      '/': (BuildContext context) => Home(),
      '/new-review': (BuildContext context) => NewReview()
    };
  }

  List<BlocProvider> _getProviders() {
    return [
      BlocProvider<AuthenticationBloc>(
        create: (BuildContext context) => AuthenticationBloc(),
      ),
      BlocProvider<ReviewsBloc>(
        create: (BuildContext context) => ReviewsBloc()..add(const LoadReviewsEvent()),
      )
    ];
  }
}