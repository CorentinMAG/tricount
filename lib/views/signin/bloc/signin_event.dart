part of 'signin_bloc.dart';

sealed class SigninEvent extends Equatable {
  const SigninEvent();

  @override
  List<Object> get props => [];
}

class SigninRequestEvent extends SigninEvent {
  final String email;
  final String password;

  const SigninRequestEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class SigninFailedEvent extends SigninEvent {}
