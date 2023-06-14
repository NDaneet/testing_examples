import '/data/message_dao.dart';
import '/data/user_dao.dart';
import 'package:flutter/material.dart';
import 'ui/home.dart';
import 'ui/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<MessageDAO>(
          lazy: false,
          create: (_) => MessageDAO(),
        ),
        ChangeNotifierProvider<UserDAO>(
          lazy: false,
          create: (_) => UserDAO(),
        )
      ],
      child: Consumer<UserDAO>(builder: (
        context,
        userDAO,
        child,
      ) {
        return MaterialApp(
          title: "Simple App",
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
          ),
          home: const Home(),
          //userDAO.isLoggedIn() ? const Home() : ,
        );
      }),
    );
  }
}
