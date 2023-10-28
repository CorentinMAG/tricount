import 'package:flutter/material.dart';
import 'package:tricount/screens/forgot_password.dart';
import 'package:tricount/screens/register.dart';
import 'package:tricount/screens/tricounts.dart';

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

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your email";
    }
    if (!value.contains('@')) {
      return "Invalid email address";
    }
    return null;
  }

  void onTapEye() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 80.0),
                const FlutterLogo(size: 80),
                const SizedBox(height: 20.0),
                const Text(
                  'TriCount',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40.0),
                TextFormField(
                  autofocus: true,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: _validateEmail,
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
                              : const Icon(Icons.visibility))),
                  obscureText: _isHidden,
                  onSaved: (value) => _password = value,
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TriCountsScreen(),
                        ),
                      );
                    }
                  },
                  child: const Text('Login'),
                ),
                const SizedBox(height: 20.0),
                TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ForgotPasswordScreen(),
                    ),
                  ),
                  child: const Text('Forgot Password?'),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Don\'t have an account?',
                  style: TextStyle(fontSize: 16),
                ),
                TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterScreen(),
                    ),
                  ),
                  child: Text('Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
