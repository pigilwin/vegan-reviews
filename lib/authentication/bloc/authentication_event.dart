part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class RequestAuthenticationEvent extends AuthenticationEvent {
  
  const RequestAuthenticationEvent();
  
  @override
  List<Object> get props => []; 
}