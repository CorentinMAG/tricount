import 'package:flutter/material.dart';
import 'package:tricount/services/api_service.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  String? _email;

  Future<void> onPressed() async {
    final data = {
      "email": _email
    };
    final response = await ApiService.instance.post("/reset", data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0, bottom: 20.0, right: 20.0, left: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close),
                  ),
                  const SizedBox(height: 70.0),
              Text(
                "Forgot Password",
                style: TextStyle(fontSize: 28.0),
              ),
              const SizedBox(height: 15.0),
              Text(
                  "Please, enter your email adress. You will then receive an email with all information to reset your password. Don't forget to check your spam !"),
              const SizedBox(height: 25.0),
              TextField(
                autofocus: true,
                onChanged: (value) => _email = value,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextButton(
                onPressed: onPressed,
                child: Text("Send Email"),
              )
            ],
          ),
      ),
    );
  }
}