import 'package:flutter/material.dart';
import 'package:tricount/models/user.dart';
import 'package:tricount/screens/account.dart';
import 'package:tricount/widgets/tricount/create_tricount.dart';
import 'package:tricount/screens/preference.dart';
import 'package:tricount/screens/scanner.dart';
import 'package:tricount/widgets/appbar.dart';
import 'package:tricount/widgets/drawer.dart';
import 'package:tricount/widgets/tricount/tricount_listview.dart';

class HomeScreen extends StatefulWidget {

  final UserModel user;
  
  const HomeScreen({required this.user, super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int section = 1;

  void onPressedQRCode() async {
   Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ScannerScreen(),
        ),
      );
  }

  void onDestinationSelected(int id) {
    Navigator.pop(context);
    setState(() => section = id);
  }
  
  @override
  Widget build(BuildContext context) {

    Widget body;

    switch(section) {
      case 0:
        body = const AccountScreen();
        break;
      case 1:
        body = const TriCountListView();
        break;
      case 2:
        body = const PreferenceScreen();
        break;
      case 3:
        body = const TriCountListView();
        break;
      default:
        body = const TriCountListView();
    }
    return Scaffold(
          appBar: TriCountAppBar(onPressedQRCode: onPressedQRCode,),
          drawer: TriCountDrawer(onDestinationSelected: onDestinationSelected),
          body: body,
          floatingActionButton: FloatingActionButton(
      tooltip: "Create new tricount",
      onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CreateTricountScreen())),
      child: const Icon(Icons.add, size: 50.0),
    ),
        );
  }
}