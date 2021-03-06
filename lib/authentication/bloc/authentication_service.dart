part of 'authentication_bloc.dart';

class AuthenticationService {

  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  Future<User> signInWithUsernameAndPassword(Email email, Password password) async {
    try {
      final result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email.value!, 
        password: password.value
      );
      return User.fromFirebaseUser(result.user!);
    } catch (e) {
      return User.empty();
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}