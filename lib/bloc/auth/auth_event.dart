import 'package:equatable/equatable.dart';
import 'package:tricount/models/user.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationUserChangedEvent extends AuthenticationEvent {
  final UserModel? user;

  const AuthenticationUserChangedEvent({required this.user});
}
