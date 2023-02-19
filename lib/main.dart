import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'pages/homepage.dart';
import 'pages/controller.dart';
import 'pages/settings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const Routes());
  });
}

class Routes extends StatefulWidget {
  const Routes({super.key});

  @override
  State<Routes> createState() => _RoutesState();
}

class _RoutesState extends State<Routes> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Liquid Games',
        routes: {
          '/': (context) => HomePage(),
          '/Settings': (context) => const Settings(),
          '/Controller': (context) => const Controller(),
        });
  }
}
