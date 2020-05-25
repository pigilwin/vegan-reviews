import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      ),
    );
  }
}