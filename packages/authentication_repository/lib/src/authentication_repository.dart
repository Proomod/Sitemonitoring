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

  Future<void> logIn(
      {required String username, required String password}) async {
    try {
      final http.Response res = await http.post(
          Uri.parse('https://dammiapi.herokuapp.com/api/account/login/'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({"username": username, "password": password}));
      print(res.statusCode);
      print(res.body);
      var data = jsonDecode(res.body);

      if (res.statusCode == 200) {
        _controller.add(AuthenticationStatus.authenticated);
      } else {
        throw Exception();
      }
      if (data['token'] != null) {
        await storage.write(key: "AuthKey", value: data['token']);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  logOut() async {
    await storage.deleteAll();
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
