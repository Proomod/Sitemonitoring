part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class SignUpFullnameChanged extends SignupEvent {
  SignUpFullnameChanged(this.fullname);
  final String fullname;

  @override
  List<Object> get props => [fullname];
}

class SignUpUserNameChanged extends SignupEvent {
  final String username;

  SignUpUserNameChanged(this.username);

  @override
  List<Object> get props => [username];
}

class SignUpPasswordChanged extends SignupEvent {
  final String password;

  const SignUpPasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class SignUpEmailChanged extends SignupEvent {
  final String email;

  SignUpEmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class SignUpConfirmPasswordsChanged extends SignupEvent {
  final String confirmPassword;

  SignUpConfirmPasswordsChanged(this.confirmPassword);

  @override
  List<Object> get props => [confirmPassword];
}

class SignUpSubmitted extends SignupEvent {}
