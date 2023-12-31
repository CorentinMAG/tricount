import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tricount/screens/forgot_password.dart';
import 'package:tricount/screens/list_tricounts.dart';
import 'package:tricount/screens/register.dart';
import 'package:tricount/services/api_service.dart';
import 'package:tricount/services/shared_preferences_service.dart';
import 'package:tricount/utils/functions.dart';
import 'package:tricount/widgets/google_sign_in_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;
  bool _isHidden = true;
  bool _isLoading = false;

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
      final data = {
        "username": _email,
        "password": _password 
      };
      try {
        setState(() {
          _isLoading = true;
        });
        final response = await ApiService.instance.post("/login", data);
        final payload = response.data;
        setState(() {
          _isLoading = false;
        });
        if (response.statusCode == 200) {
          final accessToken = payload["token"];
          final refreshToken = payload["refresh_token"];
          await SharedPrefService.instance.setValue("token", accessToken);
          await SharedPrefService.instance.setValue("refresh_token", refreshToken);
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ListTricountsScreen()));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(payload["message"]))
        );
        }
      } on DioException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message!))
        );
      }
    }
  }

  void _googleSignIn() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
        serverClientId:
            "180657159333-cvs2e7vleuqnb9kc7ku4brq8b4fd3gsb.apps.googleusercontent.com");
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }

    final google_id = googleUser.id;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                  onPressed: _isLoading ? null: onLogin,
                  child: const Text('Login'),
                ),
                TextButton(onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ForgotPasswordScreen(),
                    ),
                  ), child: Text("Forgot password?"))
                  ],
                ),
                const SizedBox(height: 50.0),
                GoogleSignInButton(onPressed: _googleSignIn),
                const SizedBox(height: 50.0),
                Text("Don't have an account?", style: TextStyle(fontSize: 16),),
                TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterScreen(),
                    ),
                  ),
                  child: Text('Register'),
                ),
                ]),
          ),
        ),
      ),
    );
  }
}
