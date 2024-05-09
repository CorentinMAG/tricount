import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tricount/views/reset/cubit/reset_cubit.dart';

class ResetScreen extends StatelessWidget {
  ResetScreen({super.key});

  String? _email;


  @override
  Widget build(BuildContext context) {
    return BlocListener<ResetCubit, ResetState>(
      listener: (context, state) {
        if (!state.isValid) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(
              top: 50.0, bottom: 20.0, right: 20.0, left: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.close),
              ),
              const SizedBox(height: 70.0),
              const Text(
                "Forgot Password",
                style: TextStyle(fontSize: 28.0),
              ),
              const SizedBox(height: 15.0),
              const Text(
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
                onPressed: () => context.read<ResetCubit>().requestPasswordReset(_email!),
                child: const Text("Send Email"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
