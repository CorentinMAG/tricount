import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tricount/services/authentication_service.dart';

part 'reset_state.dart';

class ResetCubit extends Cubit<ResetState> {
  final AuthenticationService _auth;
  ResetCubit({required authenticationRepository})
      : _auth = authenticationRepository,
        super(const ResetState());


  Future<void> requestPasswordReset(String email) async {
    try {
    await _auth.requestPasswordReset(email: email);

    } catch (e) {
      emit(
        state.copyWith(email: email, message: e.toString(), isValid: false)
      );
    }
    emit(
      state.copyWith(email: email, isValid: true)
    );
  }
}
