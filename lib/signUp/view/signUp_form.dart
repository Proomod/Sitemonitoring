import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:site_monitoring/signUp/bloc/signup_bloc.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Text(
            'Please fill this form to signup',
            style: TextStyle(fontSize: 20.0),
          ),
          _FullnameInput(),
          Flexible(
            child: _UserNameInput(),
          ),
          _EmailInput(),
          _PasswordInput(),
          _ConfirmPassworInput(),
          Text('some terms and policy'),
          _SignupButton()
        ],
      ),
    );
  }
}

class _FullnameInput extends StatelessWidget {
  const _FullnameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (previous, current) => previous.fullname != current.fullname,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            onChanged: (fullname) =>
                context.read<SignupBloc>().add(SignUpFullnameChanged(fullname)),
            decoration: InputDecoration(
              errorText: state.fullname.error.toString(),
              isDense: true,
              hintText: 'FullName',
              border: OutlineInputBorder(),
              filled: true,
            ),
          ),
        );
      },
    );
  }
}

class _UserNameInput extends StatefulWidget {
  _UserNameInput({Key? key}) : super(key: key);

  @override
  __UserNameInputState createState() => __UserNameInputState();
}

class __UserNameInputState extends State<_UserNameInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        decoration: InputDecoration(
          isDense: true,
          hintText: 'Username',
          border: OutlineInputBorder(),
          filled: true,
        ),
      ),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
          isDense: true,
          hintText: 'Password',
          border: OutlineInputBorder(),
          filled: true,
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        decoration: InputDecoration(
          isDense: true,
          hintText: 'Your Email',
          border: OutlineInputBorder(),
          filled: true,
        ),
      ),
    );
  }
}

class _ConfirmPassworInput extends StatelessWidget {
  const _ConfirmPassworInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        decoration: InputDecoration(
          isDense: true,
          hintText: 'Confirm Password',
          border: OutlineInputBorder(),
          filled: true,
        ),
      ),
    );
  }
}

class _SignupButton extends StatelessWidget {
  const _SignupButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(130, 40),
        ),
        onPressed: () {},
        child: Text('Signup',
            style: TextStyle(
              fontSize: 18.0,
            )));
  }
}
