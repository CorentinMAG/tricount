import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tricount/views/tricounts/bloc/tricount_bloc.dart';
import 'package:tricount/widgets/tricount/tricount_tile.dart';

class TriCountScreen extends StatefulWidget {
  const TriCountScreen({super.key});

  @override
  State<TriCountScreen> createState() => _TriCountListViewState();
}

class _TriCountListViewState extends State<TriCountScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(15.0),
        child:
            BlocBuilder<TricountBloc, TricountState>(builder: (context, state) {
          if (state.tricounts.isEmpty) {
            if (state.status == TricountsStatus.loading) {
              return Skeletonizer(
                enabled: true,
                child: ListView.builder(
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text('Item number $index as title'),
                        subtitle: const Text('Subtitle here'),
                        trailing: const Icon(Icons.ac_unit),
                      ),
                    );
                  },
                ),
              );
            } else if (state.status != TricountsStatus.success) {
              return const Center(
                child: Text("Failed to fetch tricounts"),
              );
            } else {
              return const Center(child: Text("No data available"));
            }
          }

          return ListView.builder(
            itemCount: state.filteredTricounts.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return TricountTile(tricount: state.filteredTricounts[index]);
            },
          );
        }));
  }
}
