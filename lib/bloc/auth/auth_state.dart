import 'package:equatable/equatable.dart';
import 'package:tricount/models/user.dart';

enum AuthenticationStatus {
  authenticated,
  unauthenticated,
  unknown
}

class AuthenticationState extends Equatable {

  final AuthenticationStatus status;
  final UserModel? user;

  const AuthenticationState._({
    required this.status,
    this.user
  });

  const AuthenticationState.authenticated({required UserModel user}): this._(status: AuthenticationStatus.authenticated, user: user);
  const AuthenticationState.unauthenticated(): this._(status: AuthenticationStatus.unauthenticated);
  const AuthenticationState.unknown(): this._(status: AuthenticationStatus.unknown);
  
  @override
  List<Object?> get props => [status, user];
}