import 'package:flutter/material.dart';
import 'package:tricount/widgets/appbar.dart';
import 'package:tricount/widgets/drawer.dart';
import 'package:tricount/widgets/tricount/create_tricount.dart';
import 'package:tricount/widgets/tricount/tricount_listview.dart';

class TriCountsScreen extends StatefulWidget {
  const TriCountsScreen({super.key});

  @override
  State<TriCountsScreen> createState() => _TriCountsScreenState();
}

class _TriCountsScreenState extends State<TriCountsScreen> {

  void onPressedQRCode() async {
    print("scan");
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: TriCountAppBar(onPressedQRCode: onPressedQRCode,),
          drawer: const TriCountDrawer(),
          body: TriCountListView(),
          floatingActionButton: CreateTriCountButton(),
        );;
  }
}