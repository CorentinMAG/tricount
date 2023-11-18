import 'package:flutter/material.dart';
import 'package:tricount/screens/login.dart';
import 'package:tricount/services/supabase_service.dart';
import 'package:tricount/services/shared_preferences_service.dart';

class TriCountDrawer extends StatefulWidget {
  const TriCountDrawer({super.key});

  @override
  State<TriCountDrawer> createState() => _TriCountDrawerState();
}

class _TriCountDrawerState extends State<TriCountDrawer> {
  int _screenIndex = 0;


  void onLogout() async {
    await SupabaseManager.supabase.auth.signOut();
    await SharedPrefService.instance.remove("IdToken");
    await SharedPrefService.instance.remove("accessToken");
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen(),), (route) => false
    );
  }

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      onDestinationSelected: (value) =>
          debugPrint("Selected destination: $value"),
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
            onPressed: onLogout,
            child: const Text("Logout"),
          ),
        )
      ],
    );
  }
}
