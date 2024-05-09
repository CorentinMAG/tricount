import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tricount/bloc/auth/auth_event.dart';
import 'package:tricount/bloc/auth/auth_state.dart';
import 'package:tricount/models/user.dart';
import 'package:tricount/services/authentication_service.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {

  final AuthenticationService _auth;
  late final StreamSubscription<UserModel?> _userSubscription;

  AuthenticationBloc({ required AuthenticationService authenticationService}): _auth = authenticationService,
    super(const AuthenticationState.unknown()) {

      _userSubscription = _auth.user.listen((UserModel? user) {
        _auth.currentUser = user;
        add(AuthenticationUserChangedEvent(user: user));
      });
      on<AuthenticationUserChangedEvent>(_onUserChange);
    }

  Future<void> _onUserChange(AuthenticationUserChangedEvent event, Emitter<AuthenticationState> emit) async {
    if (event.user != null) {
      emit(AuthenticationState.authenticated(user: event.user!));
    } else {
      emit(const AuthenticationState.unauthenticated());
    }
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}