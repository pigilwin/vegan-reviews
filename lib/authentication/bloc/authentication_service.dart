part of 'authentication_bloc.dart';

class AuthenticationService {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<User> signInWithPhoneNumber(PhoneNumber phoneNumber) async {
    
    final Completer<User> completer = Completer<User>();
    
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber.number, 
      timeout: const Duration(seconds: 60), 
      verificationCompleted: (AuthCredential credential) async {
        final AuthResult result = await _firebaseAuth.signInWithCredential(credential);
        completer.complete(User.fromFirebaseUser(result.user));
      }, 
      verificationFailed: (AuthException exception) {
        completer.complete(null);
      }, 
      codeSent: null, 
      codeAutoRetrievalTimeout: null
    ); 

    return completer.future;
  }
}