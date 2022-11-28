import 'package:equatable/equatable.dart';

import '../repository/authentication_repository.dart';
import '../repository/models/models.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState({
    this.status = AuthenticationStatus.unknown,
    this.user = User.empty,
  });

  const AuthenticationState.unknown() : this();

  const AuthenticationState.authenticated(User user)
      : this(status: AuthenticationStatus.authenticated, user: user);

  const AuthenticationState.unauthenticated()
      : this(status: AuthenticationStatus.unauthenticated);

  final AuthenticationStatus status;

  final User user;

  @override
  List<Object> get props => [status, user];
}
