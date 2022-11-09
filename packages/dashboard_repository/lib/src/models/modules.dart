import 'package:equatable/equatable.dart';

class Modules extends Equatable {
  final int id;
  final String fullname_vi;
  final String fullname_en;
  final int index_order;

  Modules(
      {required this.id,
      required this.fullname_en,
      required this.fullname_vi,
      required this.index_order});

  factory Modules.fromJson(Map<String, dynamic> json) {
    return Modules(
        id: json['id'],
        fullname_en: json['fullname_en'],
        fullname_vi: json['fullname_vi'],
        index_order: json['index_order']);
  }
  @override
  List<Object> get props => [id, fullname_en, fullname_vi, index_order];
}
