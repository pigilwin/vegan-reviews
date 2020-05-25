import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  @override
  AuthenticationState get initialState => AuthenticationInitial();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is RequestAuthenticationEvent) {
      yield* _mapRequestAuthenticationEventToState();
    }
  }

  Stream<AuthenticationState> _mapRequestAuthenticationEventToState() async* {

  }
}
