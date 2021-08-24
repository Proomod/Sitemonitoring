import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:site_monitoring/signUp/bloc/signup_bloc.dart';
import 'package:site_monitoring/signUp/view/signUp_form.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Sign Up now'),
          centerTitle: true,
        ),
        backgroundColor: Colors.black,
        body: BlocProvider(
          create: (context) => SignupBloc(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SignUpForm(),
          ),
        ));
  }
}
