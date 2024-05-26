import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tricount/views/home/cubit/home_cubit.dart';
import 'package:tricount/views/tricounts/bloc/tricount_bloc.dart';


class TriCountAppBar extends StatelessWidget implements PreferredSizeWidget {
  String title;
  void Function() onPressedQRCode;
  TabBar? bottom;
  TriCountAppBar({super.key, this.title = "Tricount", required this.onPressedQRCode, this.bottom});

  @override
  Size get preferredSize => bottom != null ? const Size.fromHeight(kToolbarHeight) * 2  : const Size.fromHeight(kToolbarHeight);


  @override
  Widget build(BuildContext context) {
    final selectedTab = context.select((HomeCubit cubit) => cubit.state.tab);

    if (selectedTab == HomeTab.tricounts) {
      final state = context.watch<TricountBloc>().state;
      return AppBar(
      title: state.search
          ? TextField(
              autofocus: true,
              decoration: const InputDecoration(
                hintText: "Search...",
                border: InputBorder.none,
              ),
              onChanged: (text) => context.read<TricountBloc>().add(TricountFilterChanged(text)),
            )
          : Text(title),
      bottom: bottom,
      actions: [
        IconButton(
          onPressed: () => context.read<TricountBloc>().add(const TricountToggleFilterMode()),
          icon: state.search
              ? const Icon(Icons.cancel)
              : const Icon(Icons.search),
        ),
        IconButton(
          onPressed: onPressedQRCode,
          icon: const Icon(Icons.qr_code)
        ),
      ],
    );

    } else {
      return AppBar();
    }

  }
}
