import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: const Text("First Screen"),
      ),
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: const Text(
                  "Go To Second Screen"
                ),
                onPressed: () => context.goNamed("second_screen"),
              ),
              ElevatedButton(
                child: const Text(
                  "Go To Third Screen"
                ),
                onPressed: () => context.goNamed("third_screen"),
              ),
            ],
        
        ),
      )
    );
  }
}