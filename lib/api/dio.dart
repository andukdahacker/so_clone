import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:so/api/api.dart';
import 'package:so/authentication/repository/models/logInResponse.dart';

import '../dashboard/repository/models/models.dart';

class DioApi implements Api {
  @override
  Future<LogInResponse?> login(String username, String password,
      [bool? rememberMe]) async {
    // TODO: implement login
    try {
      final prefs = await SharedPreferences.getInstance();
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
      if (rememberMe != null) {
        if (rememberMe) {
          await prefs.setString('username', username);
          await prefs.setString('password', password);
        }
      }

      await prefs.setString('token', logInResponse.data['token']);

      return logInResponse;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<Dashboard?> getDashboard() async {
    // TODO: implement getDashboard
    try {
      final dio = Dio(BaseOptions());
      final prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');

      dio.options.headers["Authorization"] = "Bearer $token";
      var response = await dio.post(
        "https://ver5.api.so.edu.vn/api/v5/manager/dashboard",
        data: {"app_id": 7, "user_id": 2568, "date": 1622514674},
      );

      if (response.statusCode != 200) {
        return null;
      }
      var modulesJson =
          response.data['data']['timetables'][0]['modules'] as List<dynamic>;

      var periodJson = response.data['data']['periods_info'][0]['period_info']
          as List<dynamic>;

      var generalModulesJson =
          response.data['data']['general_modules'] as List<dynamic>;

      var schoolYearStartDate =
          response.data['data']['school_year_start_date'] as int;

      var modules = modulesJson.map((e) {
        return Modules.fromJson(e);
      }).toList();

      var period = periodJson.map((e) {
        return Period.fromJson(e);
      }).toList();

      var generalModules = generalModulesJson.map(
        (e) {
          return Modules.fromJson(e);
        },
      ).toList();

      return Dashboard(
          school_year_start_date: schoolYearStartDate,
          modules: modules,
          general_modules: generalModules,
          period: period);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> setLanguagePrefs(Locale locale) async {
    // TODO: implement setLanguagePrefs

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('locale', locale.languageCode);
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<Locale?> getLanguagePrefs() async {
    // TODO: implement getLanguagePrefs
    try {
      final prefs = await SharedPreferences.getInstance();
      var languageCode = prefs.getString('locale');
      if (languageCode == null) {
        return null;
      } else {
        return Locale(languageCode);
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<Map<String, String>?> getUserInfoPrefs() async {
    // TODO: implement getUserInfoPrefs
    final prefs = await SharedPreferences.getInstance();

    var username = prefs.getString('username');
    var password = prefs.getString('password');

    if (username == null || password == null) {
      return null;
    } else {
      return {'username': username, 'password': password};
    }
  }

  @override
  Future<void> logout() async {
    // TODO: implement logout
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    await prefs.remove('password');
  }
}
