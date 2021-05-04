import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:site_monitoring/login/bloc/login_bloc.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String errorText = '';

  bool isGoogleButtonClicked = false;

  String text = 'Login';
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Text("Authentication Failed "),
            ));
        }
      },
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _UserNameInput(),
            SizedBox(
              height: 20.0,
            ),
            _PasswordInput(),
            Text(
              errorText,
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            _LoginButton(),
            SizedBox(
              height: 20.0,
            ),
            Text(
              "Forget password?",
            ),
            SizedBox(
              height: 20.0,
            ),
            SizedBox(
                child: Row(
              children: [
                Expanded(
                  child: Divider(
                    height: 10.0,
                    color: Colors.grey,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    "Become Member",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Expanded(
                  child: Divider(
                    height: 10.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            )),
            SizedBox(
              height: 20.0,
            ),
            InkWell(
              onTap: () {
                Navigator.popAndPushNamed(context, '/signupPage');
              },
              child: Text(
                "CREATE ACCOUNT",
              ),
            ),
            RawMaterialButton(
              constraints: BoxConstraints(
                minWidth: double.infinity,
                minHeight: 36.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/google_logo.png',
                    width: 26.0,
                    fit: BoxFit.fitWidth,
                  ),
                  SizedBox(width: 20.0),
                  isGoogleButtonClicked
                      ? CircularProgressIndicator()
                      : Text(
                          "Sign in with Google",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                ],
              ),
              fillColor: Colors.blueAccent,
              onPressed: () async {
                setState(() {
                  isGoogleButtonClicked = !isGoogleButtonClicked;
                });
                // await Provider.of<AuthProvider>(context, listen: false)
                //     .loginUser();

                Navigator.popAndPushNamed(
                  context,
                  '/homepage',
                );
                // Provider.of<AuthProvider>(context, listen: false).getuserData();

                // return FutureBuilder(
                //     future: Provider.of<AuthProvider>(context, listen: false)
                //         .getGoogleInfo,
                //     builder: (context, AsyncSnapshot<bool> snapshot) {
                //       if (snapshot.connectionState == ConnectionState.done) {
                //         if (snapshot.data) {
                //           return HomePage();
                //         }
                //       }
                //       return CircularProgressIndicator();
                //     });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _UserNameInput extends StatelessWidget {
  @override
  Widget build(context) {
    return BlocBuilder<LoginBloc, LoginState>(
        buildWhen: (previous, current) => previous.username != current.username,
        builder: (context, state) {
          return TextField(
            key: Key('login_usernameinput_textfield'),
            onChanged: (username) =>
                context.read<LoginBloc>().add(LoginUsernameChanged(username)),
            style: TextStyle(
              color: Colors.black,
            ),
            decoration: InputDecoration(
              errorText: state.username.invalid ? "invalid Username" : null,
              hintText: 'Your username',
              hintStyle: TextStyle(
                color: Colors.grey,
              ),
              filled: true,
              icon: Icon(
                Icons.contacts,
                color: Colors.grey,
              ),
              // fillColor: Colors.white,
              // border: OutlineInputBorder(),
            ),
          );
        });
  }
}

class _PasswordInput extends StatefulWidget {
  @override
  __PasswordInputState createState() => __PasswordInputState();
}

class __PasswordInputState extends State<_PasswordInput> {
  bool _togglePasswordVisibility = false;
  @override
  Widget build(context) {
    return BlocBuilder<LoginBloc, LoginState>(
        buildWhen: (previous, current) => previous.password != current.password,
        builder: (context, state) {
          return TextField(
            onChanged: (password) =>
                context.read<LoginBloc>().add(LoginPasswordChanged(password)),
            obscureText: _togglePasswordVisibility,
            autocorrect: false,
            style: TextStyle(
              color: Colors.black,
            ),
            decoration: InputDecoration(
              errorText: state.password.invalid ? 'Invalid Password' : null,
              suffixIcon: IconButton(
                splashRadius: 1.0,
                icon: Icon(
                  _togglePasswordVisibility
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    // ignore: unnecessary_statements
                    _togglePasswordVisibility = !_togglePasswordVisibility;
                    print(_togglePasswordVisibility);
                  });
                },
              ),
              hintText: 'Password',

              hintStyle: TextStyle(
                color: Colors.grey,
              ),
              filled: true,
              icon: Icon(
                Icons.lock,
                color: Colors.grey,
              ),
              fillColor: Colors.white,
              // border: OutlineInputBorder(),
            ),
          );
        });
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : RaisedButton(
                color: Color(0xFF6a0dad),
                key: Key('loginForm_continue_raisedButton'),
                child: Text("login"),
                onPressed: state.status.isValidated
                    ? () {
                        context.read<LoginBloc>().add(LoginSubmitted());
                      }
                    : null);
      },
    );
  }
}
//     RaisedButton(
//               child: Text("Login"),
//               color: Color(0xFF6a0dad),
//               // color: Colors.black,
//               onPressed: () async {
//                 // if (_formKey.currentState.validate()) {
//                 //   // Scaffold.of(context).showSnackBar(
//                 //   //   SnackBar(
//                 //   //     content: Text("Processing Data"),
//                 //   //   ),
//                 //   // );
//                 //   // showDialog(
//                 //   //   context: context,
//                 //   //   builder: (ctx) {
//                 //   //     return Column(
//                 //   //       mainAxisAlignment: MainAxisAlignment.center,
//                 //   //       children: [
//                 //   //         CircularProgressIndicator(
//                 //   //           backgroundColor: Colors.lightBlue,
//                 //   //         ),
//                 //   //       ],
//                 //   //     );
//                 //   //   },
//                 //   // );
//                 //   // bool result =
//                 //   //     await Provider.of<AuthProvider>(context, listen: false)
//                 //   //         .attemptLogin(_username.text, _password.text);

//                 //   // showDialog(
//                 //   //   context: context,
//                 //   //   builder: (context) {
//                 //   //     Widget contentItem = CircularProgressIndicator();

//                 //   //     return StatefulBuilder(builder: (context, setState) {
//                 //   //       return AlertDialog(
//                 //   //         content: result == false
//                 //   //             ? Text('Invalid Credentials')
//                 //   //             : contentItem,
//                 //   //       );
//                 //   //     });
//                 //   //   },
//                 //   // );
//                 //   if (result) {
//                 //     Navigator.popAndPushNamed(context, '/homepage');
//                 //   } else {
//                 //     Navigator.of(context, rootNavigator: true).pop();
//                 //     setState(() {
//                 //       errorText = "Invalid Credentials";
//                 //     });
//                   // }
//                 }
//               });
//   }
// }
