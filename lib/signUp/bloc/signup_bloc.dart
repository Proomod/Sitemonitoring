import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:site_monitoring/signUp/models/models.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupState());

  @override
  Stream<SignupState> mapEventToState(
    SignupEvent event,
  ) async* {
    if (event is SignUpFullnameChanged) {
      yield _mapFullnameChangedToState(event, state);
    } else if (event is SignUpUserNameChanged) {
      yield _mapUsernameChangedToState(event, state);
    } else if (event is SignUpEmailChanged) {
      yield _mapEmailChangedToState(event, state);
    } else if (event is SignUpPasswordChanged) {
      yield _mapPasswordChangedToState(event, state);
    } else if (event is SignUpConfirmPasswordsChanged) {
      yield _mapconfirmPasswordChangedToState(event, state);
    } else if (event is SignUpSubmitted) {
      yield* _mapSubmittedToState(event, state);
    }
  }

  SignupState _mapFullnameChangedToState(
      SignUpFullnameChanged event, SignupState state) {
    final fullname = Fullname.dirty(value: event.fullname);

    return state.copyWith(
        fullname: fullname,
        status: Formz.validate([
          fullname,
          state.username,
          state.password,
          state.email,
          state.password,
          state.confirmPassword
        ]));
  }

  SignupState _mapUsernameChangedToState(
      SignUpUserNameChanged event, SignupState state) {
    final username = Username.dirty(event.username);
    return state.copyWith(
        username: username,
        status: Formz.validate([
          username,
          state.fullname,
          state.password,
          state.email,
          state.password,
          state.confirmPassword
        ]));
  }

  SignupState _mapEmailChangedToState(
      SignUpEmailChanged event, SignupState state) {
    final email = Email.dirty(value: event.email);
    return state.copyWith(
        email: email,
        status: Formz.validate([
          email,
          state.username,
          state.password,
          state.fullname,
          state.password,
          state.confirmPassword
        ]));
  }

  Stream<SignupState> _mapSubmittedToState(
      SignUpSubmitted event, SignupState state) async* {
    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);

      try {
        //TODO : do async task of signing up

      } on Exception catch (_) {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    }
  }

  SignupState _mapPasswordChangedToState(
      SignUpPasswordChanged event, SignupState state) {
    final password = Password.dirty(
        password: state.confirmPassword.value, value: event.password);
    return state.copyWith(
        password: password,
        status: Formz.validate([
          password,
          state.username,
          state.fullname,
          state.confirmPassword,
          state.email
        ]));
  }

  SignupState _mapconfirmPasswordChangedToState(
      SignUpConfirmPasswordsChanged event, SignupState state) {
    final password = Password.dirty(
        password: state.password.value, value: event.confirmPassword);
    return state.copyWith(
        confirmPassword: password,
        status: Formz.validate(
            [password, state.username, state.fullname, state.confirmPassword]));
  }
}
