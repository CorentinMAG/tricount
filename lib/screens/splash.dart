import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tricount/bloc/auth/auth_bloc.dart';
import 'package:tricount/bloc/auth/auth_state.dart';
import 'package:tricount/services/authentication_service.dart';
import 'package:tricount/views/home/views/home.dart';
import 'package:tricount/views/signin/views/signin.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      create: (context) => AuthenticationBloc(
          authenticationService: context.read<AuthenticationService>()),
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state.status == AuthenticationStatus.authenticated) {
            return HomeScreen(user: state.user!);
          } else {
            return const SigninScreen();
          }
        },
      ),
    );
  }
}
