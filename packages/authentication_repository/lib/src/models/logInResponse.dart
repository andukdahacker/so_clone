import 'package:equatable/equatable.dart';

class LogInResponse extends Equatable {
  final int status;
  final String? message;
  final Map<String, dynamic> data;

  LogInResponse(
      {required this.status, required this.message, required this.data});

  @override
  List<Object?> get props => [status, message, data];

  // factory LogInResponse.fromJson(Map<String, dynamic> json) {
  //   return LogInResponse(
  //       status: json['status'], message: json['message'], data: json['data']);
  // }

  LogInResponse.fromJson(Map<String, dynamic> json)
      : this(
            data: json['data'],
            status: json['status'],
            message: json['message']);
}
