import 'package:dashboard_repository/dashboard_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:so/dashboard/bloc/dashboard_event.dart';
import 'package:so/dashboard/bloc/dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardRepository _dashboardRepository;

  DashboardBloc({required DashboardRepository dashboardRepository})
      : _dashboardRepository = dashboardRepository,
        super(const DashboardState()) {
    on<DashboardRequested>(_onDashboardRequested);
  }

  void _onDashboardRequested(
      DashboardRequested event, Emitter<DashboardState> emit) async {
    emit(state.copyWith(DashboardStatus.loading));
    try {
      final dashboard = await _dashboardRepository.getDashboard();
      if (dashboard == null) {
        emit(state.copyWith(DashboardStatus.failure));
      }

      emit(state.copyWith(DashboardStatus.success, dashboard));
    } catch (e) {
      print(e);
      emit(state.copyWith(DashboardStatus.failure));
    }
  }
}
