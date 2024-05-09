part of 'signup_bloc.dart';

sealed class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class SignupRequestEvent extends SignupEvent {
  final UserModel user;
  final String password;

  const SignupRequestEvent({required this.user, required this.password});

  @override
  List<Object> get props => [user, password];
}
class SignupFailedEvent extends SignupEvent {}
class SignupSuccessEvent extends SignupEvent {}
