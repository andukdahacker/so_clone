// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:so/dashboard/bloc/dashboard_bloc.dart';
import 'package:so/dashboard/bloc/dashboard_event.dart';
import 'package:so/dashboard/bloc/dashboard_state.dart';
import 'package:so/dashboard/repository/dashboard_repository.dart';
import 'package:so/dashboard/repository/models/models.dart';

class MockDashboardRepository extends Mock implements DashboardRepository {}

class MockDashboard extends Mock implements Dashboard {}

void main() {
  late DashboardBloc dashboardBloc;
  late DashboardRepository dashboardRepository;
  late Dashboard dashboard;

  setUp(() {
    dashboardRepository = MockDashboardRepository();
    dashboardBloc = DashboardBloc(dashboardRepository: dashboardRepository);
    dashboard = MockDashboard();
  });

  group('DashboardBloc', () {
    test('Initial state is [initial]', () {
      expect(dashboardBloc.state, DashboardInitial());
      dashboardBloc.close();
    });
  });

  group("DashboardRequested", () {
    blocTest(
      'emits [loading, success] when success',
      build: () {
        return dashboardBloc;
      },
      act: (bloc) {
        when(() => dashboardRepository.getDashboard())
            .thenAnswer((_) async => dashboard);
        return bloc.add(DashboardRequested());
      },
      expect: () =>
          [DashboardLoading(), DashboardSuccess(dashboard: dashboard)],
      verify: (_) {
        verify(
          () => dashboardRepository.getDashboard(),
        ).called(1);
      },
    );

    blocTest(
      'emits [loading, error] when  throw error',
      build: () {
        return dashboardBloc;
      },
      act: (bloc) {
        when(() => dashboardRepository.getDashboard()).thenThrow("error");
        return bloc.add(DashboardRequested());
      },
      expect: () => <DashboardState>[DashboardLoading(), DashboardError()],
      verify: (_) {
        verify(
          () => dashboardRepository.getDashboard(),
        ).called(1);
      },
    );
  });
}
