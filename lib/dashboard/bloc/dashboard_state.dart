import 'package:dashboard_repository/dashboard_repository.dart';
import 'package:equatable/equatable.dart';

enum DashboardStatus { initial, loading, success, failure }

class DashboardState extends Equatable {
  final Dashboard? dashboard;
  final DashboardStatus status;

  const DashboardState({this.dashboard, this.status = DashboardStatus.initial});

  DashboardState copyWith(DashboardStatus status, [Dashboard? dashboard]) {
    return DashboardState(status: status, dashboard: dashboard);
  }

  @override
  List<Object?> get props => [dashboard, status];
}
