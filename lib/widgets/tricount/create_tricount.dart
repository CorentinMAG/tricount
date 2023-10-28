import 'package:flutter/material.dart';
import 'package:tricount/screens/create_tricount.dart';

class CreateTriCountButton extends StatelessWidget {
  const CreateTriCountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      tooltip: "Create new tricount",
      onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateTricountScreen())),
      child: const Icon(Icons.add, size: 50.0),
    );
  }
}
