import 'dart:async';

import 'package:tricount/models/user.dart';
import 'package:tricount/repository/auth_repository.dart';

class AuthenticationService {

  static final AuthenticationService _instance = AuthenticationService._();

  AuthenticationService._();

  static AuthenticationService get instance => _instance;

  factory AuthenticationService() {
    return _instance;
  }

  final _userController = StreamController<UserModel?>();

  
  final AuthenticationRepository _authenticationRepository = AuthenticationRepository();
  
  Stream<UserModel?> get user async* {
    yield* _userController.stream;
  }

  UserModel? currentUser;

  Future<void> signUpUser({required UserModel user, required String password}) async {
    await _authenticationRepository.signUpUser(user: user, password: password);
  }

  Future<UserModel?> signInWithEmailAndPassword({required String email, required String password}) async {
    final UserModel? user = await _authenticationRepository.signInWithEmailAndPassword(email: email, password: password);
    _userController.add(user);
    return user;
  }

  Future<void> logout() async {
    _userController.add(null);
  }

  Future<void> requestPasswordReset({required String email}) async {
    await _authenticationRepository.requestPasswordReset(email: email);
  }

  void close() => _userController.close();
}