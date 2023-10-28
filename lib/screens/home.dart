import 'package:flutter/material.dart';
import 'package:tricount/screens/login.dart';
import 'package:tricount/screens/tricounts.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  bool _isAuth = false;

  

  @override
  Widget build(BuildContext context) {
    if (_isAuth) {
      return TriCountsScreen();
    } else {
      return LoginScreen();
    }
  }
}