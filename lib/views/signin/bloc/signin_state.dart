part of 'signin_bloc.dart';

sealed class SigninState extends Equatable {
  const SigninState();
  
  @override
  List<Object> get props => [];
}

final class SigninInitial extends SigninState {}

class SigninRequest extends SigninState {
  final String email;
  final String password;

  const SigninRequest({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];

}

class SigninFailedState extends SigninState {
  final String message;

  const SigninFailedState({required this.message});

  @override
  List<Object> get props => [message];

}
