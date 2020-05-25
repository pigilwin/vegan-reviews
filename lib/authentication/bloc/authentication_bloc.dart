import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:vegan_reviews/authentication/authentication.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';
part 'authentication_service.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {

  final AuthenticationService authenticationService = AuthenticationService();

  @override
  AuthenticationState get initialState => const NoAuthentication();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is RequestAuthenticationEvent) {
      yield* _mapRequestAuthenticationEventToState(event);
    }
  }

  Stream<AuthenticationState> _mapRequestAuthenticationEventToState(RequestAuthenticationEvent event) async* {
    yield const AuthenticationLoading();
    final User user = await authenticationService.signInWithUsernameAndPassword(event.email, event.password);
    
    if (user == null) {
      yield const NoAuthentication();
      return;
    }

    yield Authenticated(user);
  }
}
