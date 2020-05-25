import 'package:firebase_auth/firebase_auth.dart';

class User {
  
  const User({
    this.id,
    this.name
  });
  
  factory User.fromFirebaseUser(FirebaseUser user) {
    return User(
      id: user.uid,
      name: user.displayName
    );
  }

  final String name;
  final String id;
}