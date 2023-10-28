import 'package:flutter/material.dart';

class TriCountAppBar extends StatefulWidget implements PreferredSizeWidget {
  String title;
  void Function() onPressedQRCode;
  TabBar? bottom;
  TriCountAppBar({super.key, this.title = "Tricount", required this.onPressedQRCode, this.bottom});

  @override
  Size get preferredSize => bottom != null ? const Size.fromHeight(kToolbarHeight) * 2  : const Size.fromHeight(kToolbarHeight);

  @override
  State<TriCountAppBar> createState() => _TriCountAppBarState();
}

class _TriCountAppBarState extends State<TriCountAppBar> {
  bool _isSearchMode = false;
  TextEditingController _searchController = TextEditingController();

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
          : Text(widget.title),
      bottom: widget.bottom,
      actions: [
        IconButton(
          onPressed: onPressedSearch,
          icon: _isSearchMode
              ? const Icon(Icons.cancel)
              : const Icon(Icons.search),
        ),
        IconButton(
          onPressed: widget.onPressedQRCode,
          icon: const Icon(Icons.qr_code)
        ),
      ],
    );
  }
}
