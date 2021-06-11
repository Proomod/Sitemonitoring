import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();
  final storage = FlutterSecureStorage();

  Stream<AuthenticationStatus> get status async* {
    final token = await storage.read(key: 'AuthKey');
    if (token == null) {
      yield AuthenticationStatus.unauthenticated;
    } else {
      yield AuthenticationStatus.authenticated;
    }
    yield* _controller.stream;
  }

  Future<bool> logIn(
      {required String username, required String password}) async {
    try {
      var res = await http.post(
          Uri.parse('(https://dammiapi.herokuapp.com/api/account/login/'),
          body: {"username": username, "password": password});
      var data = jsonDecode(res.body);
      print(data);
      if (res.statusCode == 200) {
        _controller.add(AuthenticationStatus.authenticated);
      }
      if (data['token'] != null) {
        await storage.write(key: "AuthKey", value: data['token']);
        return true;
      }
    } catch (e) {
      print(e);
      // return false;
    }
    return false;

    // await Future.delayed(
    //     Duration(milliseconds: 300),
    //     () => _controller.add(
    //           (AuthenticationStatus.authenticated),
    //         ));
  }

  logOut() async {
    await storage.deleteAll();
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
