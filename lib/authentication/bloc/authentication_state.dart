part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}

class Authenticated extends AuthenticationState {

  const Authenticated(this.user);

  final User user;

  @override
  List<Object> get props => [user];
}

class NoAuthentication extends AuthenticationState {

  const NoAuthentication(this.wasPreviouslyLoggedIn);

  final bool wasPreviouslyLoggedIn;

  @override
  List<Object> get props => [];
}

class AuthenticationLoading extends AuthenticationState {
  const AuthenticationLoading();
  
  @override
  List<Object> get props => [];
}