part of 'authentication_bloc.dart';

class AuthenticationService {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<User> signInWithUsernameAndPassword(Username username, Password password) async {
    final AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
      email: username.value, 
      password: password.value
    );
    return User.fromFirebaseUser(result.user);
  }
}