import 'package:flutter/material.dart';
import 'package:tricount/screens/create_tricount.dart';
import 'package:tricount/screens/scanner.dart';
import 'package:tricount/widgets/appbar.dart';
import 'package:tricount/widgets/drawer.dart';
import 'package:tricount/widgets/tricount/tricount_listview.dart';

class ListTricountsScreen extends StatefulWidget {
  const ListTricountsScreen({super.key});

  @override
  State<ListTricountsScreen> createState() => _ListTricountsScreenState();
}

class _ListTricountsScreenState extends State<ListTricountsScreen> {

  void onPressedQRCode() async {
   Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ScannerScreen(),
        ),
      );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: TriCountAppBar(onPressedQRCode: onPressedQRCode,),
          drawer: const TriCountDrawer(),
          body: TriCountListView(),
          floatingActionButton: FloatingActionButton(
      tooltip: "Create new tricount",
      onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateTricountScreen())),
      child: const Icon(Icons.add, size: 50.0),
    ),
        );
  }
}