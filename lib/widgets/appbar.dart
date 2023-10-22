import 'package:flutter/material.dart';

class TriCountAppBar extends StatefulWidget implements PreferredSizeWidget {
  const TriCountAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<TriCountAppBar> createState() => _TriCountAppBarState();
}

class _TriCountAppBarState extends State<TriCountAppBar> {
  bool _isSearchMode = false;
  TextEditingController _searchController = TextEditingController();
  String _title = "Tricount";

  void onPressedSearch() {
    setState(() {
      _isSearchMode = !_isSearchMode;
    });
  }

  void onChangedText(String text) {
    debugPrint("search: $text");
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: _isSearchMode
          ? TextField(
              autofocus: true,
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: "Search...",
                border: InputBorder.none,
              ),
            onChanged: onChangedText,
            )
          : Text(_title),
      actions: [
        IconButton(
            onPressed: onPressedSearch,
            icon: _isSearchMode
                ? const Icon(Icons.cancel)
                : const Icon(Icons.search))
      ],
    );
  }
}
