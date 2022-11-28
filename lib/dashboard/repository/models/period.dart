import 'package:equatable/equatable.dart';

class Period extends Equatable {
  final int period_id;
  final String period_vi;
  final String period_en;
  final String start_time;
  final String end_time;

  const Period(
      {required this.period_id,
      required this.period_vi,
      required this.period_en,
      required this.start_time,
      required this.end_time});

  factory Period.fromJson(Map<String, dynamic> json) {
    return Period(
        period_id: json['period_id'],
        period_vi: json['period_vi'],
        period_en: json['period_en'],
        start_time: json['start_time'],
        end_time: json['end_time']);
  }

  @override
  List<Object> get props =>
      [period_id, period_vi, period_en, start_time, end_time];
}
