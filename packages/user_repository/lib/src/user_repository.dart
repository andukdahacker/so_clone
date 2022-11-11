import 'dart:async';

import 'package:dio/dio.dart';

import 'models/model.dart';

class UserRepository {
  User? _user;

  Future<User?> getUser() async {
    if (_user != null) return _user;

    try {
      var response = await Dio()
          .post("https://ver5.api.so.edu.vn/api/v5/manager/login", data: {
        "username": "gv003",
        "password": "123456@",
        "device_type": 0,
        "device_id": "11",
        "fcm_device_token": "111",
        "app_code": "demo",
        "access_token": "U0NIT09MT05MSU5FLUFQUA=="
      });

      if (response.statusCode == 200) {
        var user = User.fromJson(response.data['data']['user']);

        return user;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
