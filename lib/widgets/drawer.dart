import 'package:flutter/material.dart';

class TriCountDrawer extends StatefulWidget {
  const TriCountDrawer({super.key});

  @override
  State<TriCountDrawer> createState() => _TriCountDrawerState();
}

class _TriCountDrawerState extends State<TriCountDrawer> {
  int _screenIndex = 0;


  void onLogout() {
    debugPrint("logout");
  }

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      onDestinationSelected: (value) =>
          debugPrint("Selected desitnation: $value"),
      selectedIndex: _screenIndex,
      children: [
        const Column(
          children: [
            CircleAvatar(
              minRadius: 75.0,
              backgroundColor: Colors.transparent,
              backgroundImage: NetworkImage(
                  "https://w7.pngwing.com/pngs/340/946/png-transparent-avatar-user-computer-icons-software-developer-avatar-child-face-heroes.png"),
            ),
            SizedBox(
              height: 60.0,
            ),
            Text(
              "Welcome Corentin !",
              style:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
            ),
            SizedBox(height: 35.0),
            Divider(),
            SizedBox(height: 35.0),
          ],
        ),
        const NavigationDrawerDestination(
          icon: Icon(Icons.settings),
          label: Text("Preferences"),
        ),
        const NavigationDrawerDestination(
          icon: Icon(Icons.color_lens),
          label: Text("Theme"),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextButton(
            onPressed: () => onLogout,
            child: const Text("Logout"),
          ),
        )
      ],
    );
  }
}
