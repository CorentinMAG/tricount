import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tricount/models/user.dart';
import 'package:tricount/utils/functions.dart';
import 'package:tricount/views/signup/bloc/signup_bloc.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _username;
  String? _email;
  String? _password;
  String? _confirmPassword;

  bool _isHidden = true;

  void onTapEye() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  Future<void> onRegister() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final UserModel user = UserModel(email: _email!, username: _username!);
      BlocProvider.of<SignupBloc>(context)
          .add(SignupRequestEvent(user: user, password: _password!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupBloc, SignupState>(
      listener: (context, state) {
        if (state is SignupFailedState) {
          ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is SignupSuccessState) {
          ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("User $_username has been created, you can now login !")));
        } 
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(
              top: 50.0, bottom: 20.0, right: 20.0, left: 20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close),
                ),
                const SizedBox(height: 50.0),
                const Text(
                  "Create Account",
                  style: TextStyle(fontSize: 28.0),
                ),
                const SizedBox(height: 15.0),
                Form(
                  key: _formKey,
                  child: Column(children: [
                    TextFormField(
                      autofocus: true,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        prefixIcon: Icon(Icons.person),
                      ),
                      onSaved: (value) => _username = value,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                      ),
                      validator: validateEmail,
                      onSaved: (value) => _email = value,
                    ),
                    TextFormField(
                      obscureText: _isHidden,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: GestureDetector(
                            onTap: onTapEye,
                            child: _isHidden
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility),
                          )),
                      validator: validatePassword,
                      onSaved: (value) => _password = value,
                      onChanged: (value) => _password = value,
                    ),
                    TextFormField(
                      obscureText: _isHidden,
                      decoration: InputDecoration(
                          labelText: 'Confirm password',
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: GestureDetector(
                            onTap: onTapEye,
                            child: _isHidden
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility),
                          )),
                      validator: (value) => confirmPassword(value, _password),
                      onSaved: (value) => _confirmPassword = value,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextButton(
                      onPressed: onRegister,
                      child: const Text("Create User"),
                    )
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
