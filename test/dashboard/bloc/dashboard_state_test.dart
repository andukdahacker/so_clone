import 'package:flutter_test/flutter_test.dart';
import 'package:so/dashboard/bloc/dashboard_state.dart';

import 'dashboard_bloc_test.dart';

void main() {
  group('DashboardState', () {
    group('DashboardInitial', () {
      test("support value comparison", () {
        expect(DashboardInitial(), DashboardInitial());
      });
    });
    group('DashboardLoading', () {
      test("support value comparison", () {
        expect(DashboardLoading(), DashboardLoading());
      });
    });
    group('DashboardSuccess', () {
      var dashboard = MockDashboard();

      test("support value comparison", () {
        expect(DashboardSuccess(dashboard: dashboard),
            DashboardSuccess(dashboard: dashboard));
      });
    });
    group('DashboardError', () {
      test("support value comparison", () {
        expect(DashboardError(), DashboardError());
      });
    });
  });
}
