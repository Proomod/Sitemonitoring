import 'package:site_monitoring/login/bloc/login_bloc.dart';
import 'package:site_monitoring/login/view/login_form.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute(builder: (_) => LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: BlocProvider(
        create: (context) {
          return LoginBloc(
              authenticationRepository:
                  RepositoryProvider.of<AuthenticationRepository>(context));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              overflow: Overflow.visible,
              children: [
                Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: LoginForm(),
                  ),
                ),
                Positioned(
                  top: -50.0,
                  left: MediaQuery.of(context).size.width / 3 + 15.0,
                  child: Icon(
                    Icons.account_box,
                    size: 100.0,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
