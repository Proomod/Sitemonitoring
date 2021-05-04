import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:user_repository/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(
      {@required AuthenticationRepository authenticationRepository,
      @required UserRepository userRepository})
      : assert(authenticationRepository != null),
        assert(userRepository != null),
        this._authenticationRepository = authenticationRepository,
        this._userRepository = userRepository,
        super(AuthenticationState.unknown()) {
    this._authenticationSubscription = _authenticationRepository.status
        .listen((status) => add(AuthenticationStatusChanged(status)));
  }

  final UserRepository _userRepository;
  final AuthenticationRepository _authenticationRepository;
  StreamSubscription<AuthenticationStatus> _authenticationSubscription;

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is AuthenticationStatusChanged) {
      yield await _mapAuthenticationStatusChangedToState(event);
    } else if (event is AuthenticationLogoutRequested) {
      _authenticationRepository.logOut();
      yield AuthenticationState.unauthenticated();
    }
  }

  @override
  Future<void> close() {
    _authenticationSubscription?.cancel();
    _authenticationRepository?.dispose();
    return super.close();
  }

  Future<AuthenticationState> _mapAuthenticationStatusChangedToState(
      AuthenticationStatusChanged event) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return AuthenticationState.unauthenticated();
      case AuthenticationStatus.authenticated:
        final User user = await _tryGetUser();
        return user != null
            ? AuthenticationState.authenticated(user)
            : const AuthenticationState.unauthenticated();

      default:
        return AuthenticationState.unknown();
    }
  }

  Future<User> _tryGetUser() async {
    try {
      final User user = await _userRepository.getUser();
      return user;
    } on Exception {
      return null;
    }
  }
}
