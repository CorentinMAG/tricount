import 'package:flutter/material.dart';
import 'package:tricount/widgets/tricount_tile.dart';

class TriCountListView extends StatefulWidget {
  const TriCountListView({super.key});

  @override
  State<TriCountListView> createState() => _TriCountListViewState();
}

class _TriCountListViewState extends State<TriCountListView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          TriCountTile(),
          TriCountTile(),
          TriCountTile(),
          TriCountTile(),
          TriCountTile(),
          TriCountTile(),
          TriCountTile(),
          TriCountTile(),
          TriCountTile(),
          TriCountTile()
        ],
      ),
    );
  }
}
