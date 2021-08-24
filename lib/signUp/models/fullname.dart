import 'package:formz/formz.dart';

enum FullnameValidationError { empty }

class Fullname extends FormzInput<String, FullnameValidationError> {
  const Fullname.pure() : super.pure('');
  const Fullname.dirty({String value = ''}) : super.dirty(value);

  @override
  FullnameValidationError? validator(String value) {
    return value.isEmpty ? FullnameValidationError.empty : null;
  }
}
