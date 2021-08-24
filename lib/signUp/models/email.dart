import 'package:formz/formz.dart';

enum EmailValidationError { empty, isnotValid }

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure() : super.pure('');
  const Email.dirty({required String value}) : super.dirty(value);

  @override
  EmailValidationError? validator(String value) {
    var validEmail = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (value.isEmpty) {
      return EmailValidationError.empty;
    } else if (!validEmail.hasMatch(value)) {
      return EmailValidationError.isnotValid;
    }
  }
}
