import 'package:site_monitoring/app.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:user_repository/user_repository.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(App(
    userRepository: UserRepository(),
    authenticationRepository: AuthenticationRepository()));
