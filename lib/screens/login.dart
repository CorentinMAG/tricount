import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tricount/screens/list_tricounts.dart';
import 'package:tricount/services/supabase_service.dart';
import 'package:tricount/services/shared_preferences_service.dart';
import 'package:tricount/widgets/google_sign_in_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final StreamSubscription<AuthState> _authStateSubscription;

  @override
  void initState() {
    _authStateSubscription =
        SupabaseManager.supabase.auth.onAuthStateChange.listen((data) {
      final session = data.session;
      if (session != null) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => ListTricountsScreen()));
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _authStateSubscription.cancel();
    super.dispose();
  }

  void _googleSignIn() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
        serverClientId:
            "180657159333-cvs2e7vleuqnb9kc7ku4brq8b4fd3gsb.apps.googleusercontent.com");
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }

    final google_id = googleUser.id;

    final List user = await SupabaseManager.supabase
                            .from("User")
                            .select("*")
                            .eq("google_id", google_id);
    if (user.isEmpty) {
      await SupabaseManager.supabase
      .from("User")
      .insert({
        "username": googleUser.displayName, 
        "country": "FR", 
        "email": googleUser.email,
        "avatar": googleUser.photoUrl,
        "google_id": google_id,
        "created_at": DateTime.now().toIso8601String(),
        "roles": "{ROLE_USER}"
        });
    }
    await SharedPrefService.instance.setValue("idToken", idToken);
    await SharedPrefService.instance.setValue("accessToken", accessToken);

    await SupabaseManager.supabase.auth.signInWithIdToken(
      provider: Provider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/money-bag.png",
                height: 160.0,
              ),
              const SizedBox(height: 15.0),
              const Text(
                "Tricount",
                style: TextStyle(fontSize: 40.0),
              ),
              const SizedBox(height: 40.0),
              GoogleSignInButton(onPressed: _googleSignIn)
            ]),
      ),
    );
  }
}
