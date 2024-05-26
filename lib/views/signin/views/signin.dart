import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tricount/views/reset/views/reset.dart';
import 'package:tricount/services/authentication_service.dart';
import 'package:tricount/views/signup/bloc/signup_bloc.dart';
import 'package:tricount/views/signup/views/signup.dart';
import 'package:tricount/utils/functions.dart';
import 'package:tricount/views/signin/bloc/signin_bloc.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SigninBloc>(
      create: (context) => SigninBloc(
        authenticationRepository: context.read<AuthenticationService>(),
      ),
      child: const SigninView(),
    );
  }
}

class SigninView extends StatefulWidget {
  const SigninView({super.key});

  @override
  State<SigninView> createState() => _SigninViewState();
}

class _SigninViewState extends State<SigninView> {
  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;
  bool _isHidden = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onTapEye() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  Future<void> onLogin() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      BlocProvider.of<SigninBloc>(context)
          .add(SigninRequestEvent(email: _email!, password: _password!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SigninBloc, SigninState>(
      listener: (context, state) {
        if (state is SigninFailedState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 60.0, left: 20.0, right: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/money-bag.png",
                      height: 120.0,
                    ),
                    const SizedBox(height: 15.0),
                    const Text(
                      "Tricount",
                      style: TextStyle(fontSize: 40.0),
                    ),
                    const SizedBox(height: 40.0),
                    TextFormField(
                      autofocus: true,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                      ),
                      validator: validateEmail,
                      onSaved: (value) => _email = value,
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: GestureDetector(
                          onTap: onTapEye,
                          child: _isHidden
                              ? const Icon(Icons.visibility_off)
                              : const Icon(Icons.visibility),
                        ),
                      ),
                      obscureText: _isHidden,
                      onSaved: (value) => _password = value,
                    ),
                    const SizedBox(height: 20.0),
                    BlocBuilder<SigninBloc, SigninState>(
                      builder: (context, state) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed:
                                  state is SigninLoadingState && state.isLoading
                                      ? null
                                      : onLogin,
                              child: const Text('Login'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).push(
                                ResetPage.route(),
                              ),
                              child: const Text("Forgot password?"),
                            )
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 50.0),
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(fontSize: 16),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) => SignupBloc(
                                authenticationRepository:
                                    context.read<AuthenticationService>(),
                              ),
                              child: const SignupScreen(),
                            ),
                          ),
                        );
                      },
                      child: const Text('Register'),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
