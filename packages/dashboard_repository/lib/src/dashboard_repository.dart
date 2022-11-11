import 'package:dashboard_repository/src/models/models.dart';
import 'package:dio/dio.dart';

class DashboardRepository {
  Dashboard? _dashboard;

  Future<Dashboard?> getDashboard(String token) async {
    if (_dashboard != null) return _dashboard;

    try {
      final dio = Dio(BaseOptions());
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

      var general_modulesJson =
          response.data['data']['general_modules'] as List<dynamic>;

      var school_year_start_date =
          response.data['data']['school_year_start_date'] as int;

      var modules = modulesJson.map((e) {
        return Modules.fromJson(e);
      }).toList();

      var period = periodJson.map((e) {
        return Period.fromJson(e);
      }).toList();

      var general_modules = general_modulesJson.map(
        (e) {
          return Modules.fromJson(e);
        },
      ).toList();

      return Dashboard(
          school_year_start_date: school_year_start_date,
          modules: modules,
          general_modules: general_modules,
          period: period);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
