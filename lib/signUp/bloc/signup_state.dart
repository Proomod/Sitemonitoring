part of 'signup_bloc.dart';

class SignupState extends Equatable {
  const SignupState({
    this.status = FormzStatus.pure,
    this.fullname = const Fullname.pure(),
    this.username = const Username.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmPassword = const Password.pure(),
  });

  SignupState copyWith({
    FormzStatus? status,
    Fullname? fullname,
    Username? username,
    Email? email,
    Password? password,
    Password? confirmPassword,
  }) {
    return new SignupState(
        status: status ?? this.status,
        fullname: fullname ?? this.fullname,
        username: username ?? this.username,
        email: email ?? this.email,
        password: password ?? this.password,
        confirmPassword: confirmPassword ?? this.confirmPassword);
  }

  final FormzStatus status;
  final Fullname fullname;
  final Username username;
  final Email email;
  final Password password;
  final Password confirmPassword;

  @override
  List<Object> get props =>
      [status, fullname, username, email, password, confirmPassword];
}
