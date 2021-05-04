part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginPasswordChanged extends LoginEvent {
  LoginPasswordChanged(this.password);
  final String password;

  @override
  List<Object> get props => [password];
}

class LoginUsernameChanged extends LoginEvent {
  LoginUsernameChanged(this.username);
  final String username;

  @override
  List<Object> get props => [username];
}

class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();
}
