import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:so/dashboard/bloc/dashboard_event.dart';
import 'package:so/dashboard/bloc/dashboard_state.dart';

import '../repository/dashboard_repository.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardRepository _dashboardRepository;

  DashboardBloc({required DashboardRepository dashboardRepository})
      : _dashboardRepository = dashboardRepository,
        super(DashboardInitial()) {
    on<DashboardRequested>(_onDashboardRequested);
  }

  void _onDashboardRequested(
      DashboardRequested event, Emitter<DashboardState> emit) async {
    emit(DashboardLoading());
    try {
      final dashboard = await _dashboardRepository.getDashboard();
      if (dashboard != null) {
        emit(DashboardSuccess(dashboard: dashboard));
      } else {
        emit(DashboardError());
      }
    } catch (e) {
      emit(DashboardError());
    }
  }
}
