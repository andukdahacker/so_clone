import 'package:flutter_test/flutter_test.dart';
import 'package:so/dashboard/bloc/dashboard_event.dart';

void main() {
  group('DashboardEvent', () {
    group('DashboardRequested', () {
      test('support value comparison', () {
        expect(DashboardRequested(), DashboardRequested());
      });
    });
  });
}
