import 'package:flutter/material.dart';
import 'package:tricount/screens/home.dart';

void main() {
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
      home: const HomeScreen()
    );
  }
}
