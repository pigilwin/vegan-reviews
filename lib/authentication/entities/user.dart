import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:vegan_reviews/authentication/authentication.dart';

class User {
  
  const User({
    this.id,
    this.email
  });
  
  factory User.fromFirebaseUser(auth.User user) {
    return User(
      id: user.uid,
      email: Email(user.email)
    );
  }

  final Email email;
  final String id;
}