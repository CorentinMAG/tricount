import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tricount/models/user.dart';
import 'package:tricount/screens/account.dart';
import 'package:tricount/services/tricount_service.dart';
import 'package:tricount/views/home/cubit/home_cubit.dart';
import 'package:tricount/views/tricounts/bloc/tricount_bloc.dart';
import 'package:tricount/views/tricounts/edit/views/edit_tricount.dart';
import 'package:tricount/screens/preference.dart';
import 'package:tricount/screens/scanner.dart';
import 'package:tricount/widgets/appbar.dart';
import 'package:tricount/widgets/drawer.dart';
import 'package:tricount/views/tricounts/views/tricounts.dart';

class HomeScreen extends StatelessWidget {
  final UserModel user;
  HomeScreen({super.key, required this.user});
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context) {
    return {
      "/": (context) => HomeView(user: user)
    };
  }

  @override
  Widget build(BuildContext context) {
    var routeBuilders = _routeBuilders(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<TricountBloc>(
          create: (context) => TricountBloc(
            repository: context.read<TricountService>(),
          )..add(const TricountSubscriptionRequested()),
        ),
        BlocProvider<HomeCubit>(
          create: (_) => HomeCubit(),
        )
      ],
      //child: HomeView(user: user),
      child: Navigator(
        key: _navigatorKey,
        initialRoute: "/",
        onGenerateRoute: (settings) {
          return MaterialPageRoute(builder: (context) => routeBuilders[settings.name]!(context));
        },
      )
    );
  }
}

class HomeView extends StatelessWidget {
  final UserModel user;
  const HomeView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final selectedTab = context.select((HomeCubit cubit) => cubit.state.tab);

    Widget body;

    switch (selectedTab) {
      case HomeTab.account:
        body = const AccountScreen();
        break;
      case HomeTab.tricounts:
        body = const TriCountScreen();
        break;
      case HomeTab.preferences:
        body = const PreferenceScreen();
        break;
      case HomeTab.theme:
        body = const TriCountScreen();
        break;
      default:
        body = const TriCountScreen();
    }

    return Scaffold(
      appBar: TriCountAppBar(
        onPressedQRCode: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(value: BlocProvider.of<TricountBloc>(context), child:const ScannerScreen() ) ,
          ),
        ),
      ),
      drawer: TriCountDrawer(
        onDestinationSelected: (int id) {
          Navigator.pop(context);
          context.read<HomeCubit>().setTab(HomeTab.values[id]);
        },
      ),
      body: body,
      floatingActionButton: FloatingActionButton(
        tooltip: "Create new tricount",
        onPressed: () => Navigator.of(context).push(
          EditTricountScreen.route(),
        ),
        child: const Icon(Icons.add, size: 50.0),
      ),
    );
  }
}
