import 'package:formz/formz.dart';

enum PasswordValidationError { empty, doesNotMatch }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure({this.password = ''}) : super.pure('');
  const Password.dirty({required this.password, String value = ''})
      : super.dirty(value);
  final String password;

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty)
      return PasswordValidationError.empty;
    else if (value.compareTo(password) != 0)
      return PasswordValidationError.doesNotMatch;
  }
}
