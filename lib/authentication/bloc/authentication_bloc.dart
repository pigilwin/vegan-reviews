import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

import 'package:vegan_reviews/authentication/authentication.dart';
import 'package:vegan_reviews/shared/shared.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';
part 'authentication_service.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> with Network {

  AuthenticationBloc(): super(const NoAuthentication(false));

  final AuthenticationService authenticationService = AuthenticationService();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is RequestAuthenticationEvent) {
      yield* _mapRequestAuthenticationEventToState(event);
    }
    if (event is SignOutEvent) {
      yield* _mapSignOutEventToState();
    }
  }

  Stream<AuthenticationState> _mapRequestAuthenticationEventToState(RequestAuthenticationEvent event) async* {
    yield const AuthenticationLoading();

    if (await hasNoNetworkAccess()) {
      yield const NoAuthentication(false);
      return;
    }

    final user = await authenticationService.signInWithUsernameAndPassword(event.email, event.password);
        
    if (user.isInvalid) {
      yield const NoAuthentication(false);
      return;
    }

    yield Authenticated(user);
  }

  Stream<AuthenticationState> _mapSignOutEventToState() async* {
    yield const AuthenticationLoading();
    await authenticationService.signOut();
    yield const NoAuthentication(true);
  }
}
