import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "model/favourites_model.dart";
import 'screens/favourites_screen.dart';
import "screens/fruits_screen.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FavouriteModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
          useMaterial3: true,
        ),
        initialRoute: "/",
        routes: <String, WidgetBuilder>{
          "/": (context) => const FruitScreen(),
          "/favourite_screen": (context) => const FavouriteScreen()
        },
      ),
    );
  }
}
