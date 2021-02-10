import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:vegan_reviews/authentication/authentication.dart';

class User {
  
  const User(
    this.id,
    this.email
  );
  
  factory User.fromFirebaseUser(auth.User user) {
    return User(
      user.uid,
      Email(user.email)
    );
  }

  factory User.empty() {
    return User(
      '',
      Email('')
    );
  }

  final Email email;
  final String id;

  bool get isValid => id.isNotEmpty && email.value.isNotEmpty;
  bool get isInvalid => !isValid;
}