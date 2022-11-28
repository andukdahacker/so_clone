import 'dart:async';

import 'package:so/api/dio.dart';

import 'models/models.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<LogInResponse?> logIn(
      {required String username,
      required String password,
      bool? rememberMe}) async {
    LogInResponse? logInResponse =
        await DioApi().login(username, password, rememberMe);
    if (logInResponse == null) {
      _controller.add(AuthenticationStatus.unauthenticated);
    } else {
      if (logInResponse.status == 0) {
        _controller.add(AuthenticationStatus.unauthenticated);
      } else if (logInResponse.status == 1) {
        _controller.add(AuthenticationStatus.authenticated);
      }
    }
    if (logInResponse != null) return logInResponse;
    return null;
  }

  Future<Map<String, String>?> getUserInfoPrefs() async {
    return await DioApi().getUserInfoPrefs();
  }

  void logOut() async {
    await DioApi().logout();
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();

  User? _user;

  Future<User?> getUser() async {
    if (_user != null) return _user;

    var response = await DioApi().login('gv003', '123456@');

    if (response != null) {
      var user = User.fromJson(response.data['user']);
      return user;
    } else {
      return null;
    }
  }
}
