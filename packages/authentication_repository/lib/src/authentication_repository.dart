import 'dart:async';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:dio/dio.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> signUp(
      {required String username, required String password}) async {
    await Future.delayed(Duration(milliseconds: 300),
        () => _controller.add(AuthenticationStatus.authenticated));
  }

  Future<LogInResponse?> logIn({
    required String username,
    required String password,
  }) async {
    try {
      var response = await Dio()
          .post("https://ver5.api.so.edu.vn/api/v5/manager/login", data: {
        "username": username,
        "password": password,
        "device_type": 0,
        "device_id": "11",
        "fcm_device_token": "111",
        "app_code": "demo",
        "access_token": "U0NIT09MT05MSU5FLUFQUA=="
      });

      LogInResponse logInResponse = LogInResponse.fromJson(response.data);

      if (logInResponse.status == 0) {
        _controller.add(AuthenticationStatus.unauthenticated);
      } else if (logInResponse.status == 1) {
        _controller.add(AuthenticationStatus.authenticated);
      }

      return logInResponse;
    } catch (e) {
      print(e);

      return null;
    }
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
