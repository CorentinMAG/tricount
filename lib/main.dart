import 'package:flutter/material.dart';
import 'package:tricount/screens/login.dart';
import 'package:tricount/services/api_service.dart';
import 'package:tricount/services/shared_preferences_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await SharedPrefService.instance.initialize();
  await ApiService.instance.initialize();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Tricount",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      home: LoginScreen()
    );
  }
}
