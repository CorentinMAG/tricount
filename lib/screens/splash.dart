import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tricount/screens/login.dart';
import 'package:tricount/screens/list_tricounts.dart';
import 'package:tricount/services/api_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _redirect();
  }

  Future<void> _redirect() async {
    await Future.delayed(Duration.zero);
    if (!mounted) {
      return;
    }

    try {
      final response = await ApiService.instance.get("/me");
      if (response.statusCode == 200) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ListTricountsScreen()));
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    } on DioException catch (e) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator())
    );
  }
}