import 'package:equatable/equatable.dart';

import '../repository/models/models.dart';

class DashboardState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {
  @override
  List<Object?> get props => [];
}

class DashboardLoading extends DashboardState {
  @override
  List<Object?> get props => [];
}

class DashboardSuccess extends DashboardState {
  final Dashboard dashboard;

  DashboardSuccess({required this.dashboard});

  DashboardSuccess copyWith(Dashboard dashboard) {
    return DashboardSuccess(dashboard: dashboard);
  }

  @override
  List<Object?> get props => [dashboard];
}

class DashboardError extends DashboardState {
  @override
  List<Object?> get props => [];
}
