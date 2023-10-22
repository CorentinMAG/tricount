import 'package:flutter/material.dart';
import 'package:tricount/widgets/appbar.dart';
import 'package:tricount/widgets/create_tricount.dart';
import 'package:tricount/widgets/drawer.dart';
import 'package:tricount/widgets/tricount_listview.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TriCountAppBar(),
        drawer: const TriCountDrawer(),
        body: TriCountListView(),
        floatingActionButton: CreateTriCountButton(),
      );
  }
}