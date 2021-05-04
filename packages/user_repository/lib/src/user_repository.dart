import 'dart:async';
import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'models/models.dart';

class UserRepository {
  User _user;

  Future<User> getUser() async {
    final storage = FlutterSecureStorage();
    String token = await storage.read(key: 'AuthKey');
    if (_user != null) return _user;

    var res = await http
        .get("https://dammiapi.herokuapp.com/api/account/profile", headers: {
      'Authorization': 'Token $token',
    });
    var data = json.decode(res.body);
    if (res.statusCode == 200) {
      _user = User(
          email: data['email'], id: Uuid().v4(), userName: data['username']);
    }
    return _user;

    // return Future.delayed(
    //   const Duration(milliseconds: 300),
    //   () => _user = User(id: Uuid().v4()),
    // );
  }
}
