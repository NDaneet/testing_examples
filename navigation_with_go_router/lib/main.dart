 import 'package:flutter/material.dart';
import 'navigation/app_router.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});


  final _route = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _route.route,
    );
  }
}