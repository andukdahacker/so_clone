import 'package:so/api/dio.dart';

import 'models/models.dart';

class DashboardRepository {
  Dashboard? _dashboard;

  Future<Dashboard?> getDashboard() async {
    if (_dashboard != null) return _dashboard;
    var result = await DioApi().getDashboard();
    if (result == null) {
      return null;
    } else {
      return result;
    }
  }
}
