import 'package:flutter/material.dart';
import 'package:tricount/widgets/appbar.dart';

class TricountScreen extends StatefulWidget {
  const TricountScreen({super.key});

  @override
  State<TricountScreen> createState() => _TricountScreenState();
}

class _TricountScreenState extends State<TricountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TriCountAppBar(),
    );
  }
}