part of 'reset_cubit.dart';

final class ResetState extends Equatable {
  final bool isValid;
  final String message;
  final String email;

  const ResetState(
      {this.isValid = true, this.message = "", this.email = ""});

  @override
  List<Object> get props => [isValid, message, email];

  ResetState copyWith({String? email, bool? isValid, String? message}) {
    return ResetState(
        email: email ?? this.email,
        isValid: isValid ?? this.isValid,
        message: message ?? this.message);
  }
}
