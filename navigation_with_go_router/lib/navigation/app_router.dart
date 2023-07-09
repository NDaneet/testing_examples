import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "../screens/fourth_screen.dart";
import "../screens/third_screen.dart";
import "../screens/first_screen.dart";
import "../screens/second_screen.dart";

class AppRouter {
  final route = GoRouter(
      routes: [
      
        GoRoute(
          path: '/',
          name: "first_screen",
          builder: (context, state) => const FirstScreen(),
          routes: [
            GoRoute(
              path: "second_screen",
              name: 'second_screen',
              builder: (context, state) => const SecondScreen(),
            )
          ],
        ),
        GoRoute(
            path: "/third_screen",
            name: "third_screen",
            builder: (context, state) => const ThirdScreen(),
            routes: [
              GoRoute(
                path: "fourth_screen",
                name: "fourth_screen",
                builder: (context, state) => const FourthScreen(),
              )
            ]),
      ],
      errorBuilder: (context, state) {
        return  Scaffold(
            body: Center(
              child: Text(
                state.error.toString(),
              ),
            ),
          );
    
      });
}
