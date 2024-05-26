import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tricount/screens/splash.dart';
import 'package:tricount/observer/observer.dart';
import 'package:tricount/services/api_service.dart';
import 'package:tricount/services/authentication_service.dart';
import 'package:tricount/services/shared_preferences_service.dart';
import 'package:tricount/services/tricount_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const AppObserver();

  await SharedPrefService.instance.initialize();
  await ApiService.instance.initialize();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationService>(
          create: (context) => AuthenticationService(),
        ),
        RepositoryProvider<TricountService>(
          create: (context) => TricountService(),
        )
      ],
      child: MaterialApp(
        title: "Tricount",
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(useMaterial3: true),
        home: const SplashScreen(),
      ),
    );
  }
}
