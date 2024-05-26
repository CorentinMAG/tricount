import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tricount/bloc/auth/auth_bloc.dart';
import 'package:tricount/bloc/auth/auth_event.dart';
import 'package:tricount/services/shared_preferences_service.dart';

class TriCountDrawer extends StatefulWidget {
  void Function(int) onDestinationSelected;
  TriCountDrawer({super.key, required this.onDestinationSelected});

  @override
  State<TriCountDrawer> createState() => _TriCountDrawerState();
}

class _TriCountDrawerState extends State<TriCountDrawer> {
  int _screenIndex = -1;

  void onLogout() async {
    await SharedPrefService.instance.remove("token");
    await SharedPrefService.instance.remove("refresh_token");
    BlocProvider.of<AuthenticationBloc>(context)
        .add(const AuthenticationUserChangedEvent(user: null));
  }

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user)!;
    return NavigationDrawer(
      onDestinationSelected: widget.onDestinationSelected,
      selectedIndex: _screenIndex,
      children: [
        Column(
          children: [
            const SizedBox(
              height: 40.0,
            ),
            Container(
              width: 150.0,
              height: 150.0,
              decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
              child: ClipOval(child: Image.network(user.avatar, fit: BoxFit.cover))
            ),
            const SizedBox(
              height: 40.0,
            ),
            Text(
              "Welcome ${user.username}!",
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
            ),
            const SizedBox(height: 35.0),
            const Divider(),
            const SizedBox(height: 35.0),
          ],
        ),
        const NavigationDrawerDestination(
            icon: Icon(Icons.account_circle), label: Text("Account")),
        const NavigationDrawerDestination(
            icon: Icon(Icons.list), label: Text("Tricounts")),
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
