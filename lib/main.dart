import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotwatch/data/login_form/bloc/login_form_bloc.dart';
import 'package:spotwatch/data/reverse_beacon/bloc/reverse_beacon_bloc.dart';
import 'package:spotwatch/models/reverse_beacon_feed.dart';
import 'package:spotwatch/ui/screens/main_screen.dart';
import 'package:spotwatch/ui/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ReverseBeaconBloc>(
          create: (context) => ReverseBeaconBloc(ReverseBeaconFeed()),
        ),
        BlocProvider<LoginFormBloc>(
          create: (context) => LoginFormBloc(),
        ),
      ],
      child: MaterialApp(
        routes: {
          '/': (context) => const Home(),
          '/app': (context) => const MainScreen()
        },
        title: 'Spotwatch',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 58, 91, 180)),
          useMaterial3: true,
        ),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromARGB(255, 145, 187, 221),
            Colors.white,
            Color.fromARGB(255, 145, 187, 221),
          ],
        )),
        child: const Center(child: LoginScreen()),
      ),
    );
  }
}
