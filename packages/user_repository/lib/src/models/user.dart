import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String fullname;
  final String avatar;

  const User({
    required this.id,
    required this.fullname,
    required this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      avatar: json['avatar'],
      fullname: json['fullname'],
    );
  }

  static const empty = User(
    id: 0,
    fullname: "",
    avatar: "",
  );
  @override
  List<Object?> get props => [
        id,
        fullname,
        avatar,
      ];
}
