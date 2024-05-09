part of 'signup_bloc.dart';

sealed class SignupState extends Equatable {
  const SignupState();
  
  @override
  List<Object> get props => [];
}

final class SignupInitial extends SignupState {}

class SignupRequestState extends SignupState {
  final UserModel user;

  const SignupRequestState({required this.user});

  @override
  List<Object> get props => [user];
}
class SignupFailedState extends SignupState {
  final String message;

  const SignupFailedState({required this.message});

  @override
  List<Object> get props => [message];
}

class SignupSuccessState extends SignupState {}
