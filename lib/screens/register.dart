import 'package:flutter/material.dart';
import 'package:tricount/utils/functions.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _firstname;
  String? _lastname;
  String? _email;
  String? _password;
  String? _confirmPassword;

  bool _isHidden = true;

  void onTapEye() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  void onRegister() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      labelText: 'First name',
                      prefixIcon: Icon(Icons.person),
                    ),
                    onSaved: (value) => _firstname = value,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Last name',
                      prefixIcon: Icon(Icons.person),
                    ),
                    onSaved: (value) => _lastname = value,
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
                      suffixIcon: GestureDetector(onTap: onTapEye, child: _isHidden ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),)
                    ),
                    validator: validatePassword,
                    onSaved: (value) => _password = value,
                  ),
                  TextFormField(
                    obscureText: _isHidden,
                    decoration: InputDecoration(
                      labelText: 'Confirm password',
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: GestureDetector(onTap: onTapEye, child: _isHidden ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),)
                    ),
                    validator: (value) => confirmPassword(_password, value),
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
    );
  }
}
