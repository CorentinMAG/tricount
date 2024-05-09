import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tricount/models/user.dart';
import 'package:tricount/services/authentication_service.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final AuthenticationService _auth;
  SignupBloc({required authenticationRepository})
      : _auth = authenticationRepository,
        super(SignupInitial()) {
    on<SignupRequestEvent>(_onSignup);
  }


  Future<void> _onSignup(SignupRequestEvent event, Emitter<SignupState> emit) async {
    try {
      await _auth.signUpUser(user: event.user, password: event.password);
      emit(SignupSuccessState());
    } catch (e) {
      emit(SignupFailedState(message: e.toString()));
    }
  }
}
