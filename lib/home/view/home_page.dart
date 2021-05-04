import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:site_monitoring/authentication/authentication.dart';

class HomePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xff1d1e33),
      appBar: AppBar(
        elevation: 0.0,
        // backgroundColor: Color(0xff1d1e33),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFFEB1555),
              ),
              child: Text(
                "Monitoring System",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
              onTap: () {
                Navigator.popAndPushNamed(
                  context,
                  '/profile',
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('My Reports'),
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text('About Us'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: () async {
                context
                    .read<AuthenticationBloc>()
                    .add(AuthenticationLogoutRequested());
              },
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            color: Color(0xFFEB1555),
            child: Builder(
              builder: (context) {
                final userId = context.select(
                    (AuthenticationBloc bloc) => bloc.state.user.userName);
                return userId.isNotEmpty
                    ? Text(
                        'Welcome $userId',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                        ),
                      )
                    : Text('');
              },
            ),
          ),
          InteractiveBox(
              textName: 'My Projects',
              tagNo: 1,
              tapFunction: () {
                Navigator.pushNamed(context, '/projectList');
              }),
          InteractiveBox(
            tagNo: 2,
            textName: 'SpiritLevel',
            tapFunction: () {
              Navigator.pushNamed(context, '/spiritLevelPage');
            },
          ),
          InteractiveBox(
            tagNo: 3,
            textName: 'NextTest',
            tapFunction: () {
              Navigator.pushNamed(context, '/cementConsistencyPdf');
            },
          )
        ],
      ),
    );
  }
}

class InteractiveBox extends StatelessWidget {
  final String textName;
  final int tagNo;
  final Function tapFunction;

  InteractiveBox({this.textName, this.tapFunction, this.tagNo});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: tapFunction,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Color(0xFF111328),
          ),
          margin: EdgeInsets.all(20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons8-project-24.png',
                height: 40.0,
                fit: BoxFit.cover,
                width: 40.0,
                color: Colors.red,
              ),
              SizedBox(
                width: 10.0,
              ),
              Hero(
                tag: 'listPage$tagNo',
                child: Text(
                  this.textName,
                  style: TextStyle(
                    fontSize: 40.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
