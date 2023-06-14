import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: const Text("Third Screen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text(
                "Go To Fourth Screen"
              ),
              onPressed: () => context.goNamed("fourth_screen"),
            ),
           ElevatedButton(
        child: const Text("Go To First Screen"),
        onPressed: () => context.goNamed("first_screen"),
      ),
          ],
        )
      )
    );
  }
}