import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final _formKey = GlobalKey<FormState>();

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
                  const SizedBox(height: 50.0),
              Text(
                "Create Account",
                style: TextStyle(fontSize: 28.0),
              ),
              const SizedBox(height: 15.0),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextField(
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextButton(
                onPressed: () {},
                child: Text("Create User"),
              )
                  ]
                ),
              ),
              
            ],
          ),
      ),
    );
  }
}