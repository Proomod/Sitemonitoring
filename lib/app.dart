import 'package:site_monitoring/coarseAggregateTest/SGandWAtest/pdfPage/pdfView.dart';
import 'package:site_monitoring/fineAggregateTests/clayContent/pdfPage/pdfView.dart';
import 'package:site_monitoring/fineAggregateTests/fineUnitWtTest/pdfPage/pdfView.dart';
import 'package:site_monitoring/fineAggregateTests/sieveAnalysis/pdfPage/pdfView.dart';
import 'package:site_monitoring/fineAggregateTests/specificGravity/pdfPage/pdfViewer.dart';
import 'package:site_monitoring/projectList/view/projectpage.dart';
import 'package:site_monitoring/spiritlevel/spiritlevel.dart';
import 'package:site_monitoring/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'authentication/authentication.dart';
import 'home/home.dart';
import 'login/login.dart';
import 'signUp/signUp.dart';

class App extends StatelessWidget {
  final UserRepository userRepository;
  final AuthenticationRepository authenticationRepository;

  const App(
      {Key? key,
      required this.userRepository,
      required this.authenticationRepository})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: BlocProvider(
        create: (context) => AuthenticationBloc(
            authenticationRepository: authenticationRepository,
            userRepository: userRepository),
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState? get _navigator => _navigatorKey.currentState;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
          primaryColor: Color(0xff1d1e33),
          textTheme: TextTheme().copyWith(
              // bodyText2: TextStyle(
              //   color: Color(0xFf8d8e98),
              // ),
              ),
          cardColor: Colors.black,
          accentColor: Colors.black12,
          scaffoldBackgroundColor: Color(0xff1d1e33),
          buttonTheme: ButtonThemeData().copyWith(
            minWidth: double.infinity,
          )),
      navigatorKey: _navigatorKey,
      builder: (context, child) =>
          BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          print(state.status);
          switch (state.status) {
            case AuthenticationStatus.authenticated:
              _navigator!
                  .pushAndRemoveUntil<void>(HomePage.route(), (route) => false);
              break;
            case AuthenticationStatus.unauthenticated:
              _navigator!.pushNamed<void>(
                '/loginPage',
              );
              break;
            default:
              break;
          }
        },
        child: child,
      ),
      onGenerateRoute: (_) => SplashPage.route(),
      routes: {
        '/spiritLevelPage': (context) => SpiritLevel(),
        '/projectList': (context) => ProjectPage(),
        '/cementConsistency': (context) => SieveAnalysisTestPdf(),
        '/loginPage': (context) => LoginPage(),
        '/signupPage': (context) => SignUpPage()
      },
    );
  }
}
