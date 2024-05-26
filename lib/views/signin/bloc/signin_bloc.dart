import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tricount/services/authentication_service.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  final AuthenticationService _auth;
  SigninBloc({ required authenticationRepository})
      : _auth = authenticationRepository,
        super(SigninInitial()) {
    on<SigninRequestEvent>(_onSignin);
  }

  Future<void> _onSignin(SigninRequestEvent event, Emitter<SigninState> emit) async {
    emit(const SigninLoadingState(isLoading: true));
    try {
      await _auth.signInWithEmailAndPassword(email: event.email, password: event.password);
    } catch (e) {
      emit(SigninFailedState(message: e.toString()));
    } finally {
      emit(const SigninLoadingState(isLoading: false));
    }
  }
}
