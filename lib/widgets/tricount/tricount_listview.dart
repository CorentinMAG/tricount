import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tricount/models/tricount.dart';
import 'package:tricount/repository/tricount_repository.dart';
import 'package:tricount/widgets/tricount/tricount_tile.dart';

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
      child: FutureBuilder(
        future: context.read<TricountRepository>().getUserTricounts(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            final List<Tricount> tricounts = snapshot.data!;
            return ListView.builder(
              itemCount: tricounts.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return TricountTile(tricount: tricounts[index]);
              },
            );
          }
        }
      )
    );
  }
}
