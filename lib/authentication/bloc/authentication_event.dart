part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class RequestAuthenticationEvent extends AuthenticationEvent {
  
  const RequestAuthenticationEvent(this.number);

  final PhoneNumber number;
  
  @override
  List<Object> get props => [number.number]; 
}