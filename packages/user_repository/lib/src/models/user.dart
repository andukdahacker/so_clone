import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String fullname;
  final String avatar;
  final dynamic user_roles;

  const User(
      {required this.id,
      required this.fullname,
      required this.avatar,
      required this.user_roles});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        avatar: json['avatar'],
        fullname: json['fullname'],
        user_roles: json['user_roles']);
  }

  static const empty = User(id: 0, fullname: "", avatar: "", user_roles: "");
  @override
  List<Object?> get props => [id, fullname, avatar, user_roles];
}
