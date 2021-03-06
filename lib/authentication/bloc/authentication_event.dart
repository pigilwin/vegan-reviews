part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class RequestAuthenticationEvent extends AuthenticationEvent {
  
  const RequestAuthenticationEvent(this.email, this.password);

  final Email email;
  final Password password;
  
  @override
  List<Object?> get props => [email.value, password.value]; 
}

class PersistenceSignInEvent extends AuthenticationEvent {

  const PersistenceSignInEvent(this.user);

  final User user;

  @override
  List<Object> get props => [user];

}

class SignOutEvent extends AuthenticationEvent {

  const SignOutEvent();

  @override
  List<Object> get props => [];
}