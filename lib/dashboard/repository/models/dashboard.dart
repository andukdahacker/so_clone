import "models.dart";
import 'package:equatable/equatable.dart';

class Dashboard extends Equatable {
  final int school_year_start_date;
  final List<Modules> modules;
  final List<Period> period;
  final List<Modules> general_modules;

  const Dashboard(
      {required this.school_year_start_date,
      required this.modules,
      required this.period,
      required this.general_modules});

  @override
  // TODO: implement props
  List<Object?> get props =>
      [school_year_start_date, modules, period, general_modules];
}
