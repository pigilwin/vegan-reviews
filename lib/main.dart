import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vegan_reviews/application.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Application(key: Key('application-instance'),));
}