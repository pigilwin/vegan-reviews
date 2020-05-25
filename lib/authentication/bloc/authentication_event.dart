part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class RequestAuthenticationEvent extends AuthenticationEvent {
  
  const RequestAuthenticationEvent(this.username, this.password);

  final Username username;
  final Password password;
  
  @override
  List<Object> get props => [username.value, password.value]; 
}