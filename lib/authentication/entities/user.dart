import 'package:firebase_auth/firebase_auth.dart';
import 'package:vegan_reviews/authentication/authentication.dart';

class User {
  
  const User({
    this.id,
    this.email
  });
  
  factory User.fromFirebaseUser(FirebaseUser user) {
    return User(
      id: user.uid,
      email: Email(user.email)
    );
  }

  final Email email;
  final String id;
}