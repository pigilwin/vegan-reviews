import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegan_reviews/reviews/reviews.dart';

class Application extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: const [],
      child: MaterialApp(
        title: 'Vegan Reviews',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        onGenerateRoute: onGenerateRoute,
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
      '/': (BuildContext context) => Home()
    };
  }
}