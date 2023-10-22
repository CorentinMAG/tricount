import 'package:flutter/material.dart';

class TriCountDrawer extends StatefulWidget {
  const TriCountDrawer({super.key});

  @override
  State<TriCountDrawer> createState() => _TriCountDrawerState();
}

class _TriCountDrawerState extends State<TriCountDrawer> {
  int _screenIndex = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      onDestinationSelected: (value) =>
          debugPrint("Selected desitnation: $value"),
      selectedIndex: _screenIndex,
      children: [
        Column(
          children: [
            CircleAvatar(
              minRadius: 75.0,
              backgroundColor: Colors.transparent,
              backgroundImage: NetworkImage(
                  "https://w7.pngwing.com/pngs/340/946/png-transparent-avatar-user-computer-icons-software-developer-avatar-child-face-heroes.png"),
            ),
            const SizedBox(
              height: 60.0,
            ),
            const Text(
              "Welcome Corentin !",
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
            ),
            const SizedBox(height: 35.0),
            const Divider(),
            const SizedBox(height: 35.0),
          ],
        ),
        NavigationDrawerDestination(
          icon: Icon(Icons.settings),
          label: Text("Preferences"),
        ),
        NavigationDrawerDestination(
          icon: Icon(Icons.color_lens),
          label: Text("Theme"),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextButton(
            onPressed: () => debugPrint("Logout"),
            child: Text("Logout"),
          ),
        )
      ],
    );
  }
}
