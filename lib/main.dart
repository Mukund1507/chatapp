import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'screens/home_page.dart';
import 'screens/login_page.dart';
import 'screens/registration_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
      routes: {
        LoginPage.routeName: (ctx) => LoginPage(),
        RegistrationPage.routeName: (ctx) => RegistrationPage(),
        HomePage.routeName: (ctx) => const HomePage(),
      },
    );
  }
}
