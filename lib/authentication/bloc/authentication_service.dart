part of 'authentication_bloc.dart';

class AuthenticationService {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<User> signInWithUsernameAndPassword(Email email, Password password) async {
    final AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
      email: email.value, 
      password: password.value
    );
    return User.fromFirebaseUser(result.user);
  }
}