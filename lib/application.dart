import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vegan_reviews/authentication/authentication.dart';
import 'package:vegan_reviews/reviews/reviews.dart';

class Application extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: _getProviders(),
      child: MaterialApp(
        title: 'Vegan Reviews',
        theme: ThemeData(
          primarySwatch: Colors.green,
          scaffoldBackgroundColor: Colors.blueGrey[50],
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        onGenerateRoute: onGenerateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final builder = _getRoutes(settings)[settings.name];
    return MaterialPageRoute(
      builder: builder,
      settings: settings
    );
  }

  Map<String, WidgetBuilder> _getRoutes(RouteSettings settings) {
    return {
      '/': (BuildContext context) => Home(),
      '/review/new': (BuildContext context) => NewReview(),
      '/review/edit': (BuildContext context) => EditReview(settings.arguments)
    };
  }

  List<BlocProvider> _getProviders() {
    return [
      BlocProvider<AuthenticationBloc>(
        create: (BuildContext context) => AuthenticationBloc(),
      ),
      BlocProvider<ReviewsBloc>(
        create: (BuildContext context) => ReviewsBloc(),
      )
    ];
  }
}