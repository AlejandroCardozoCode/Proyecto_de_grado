import 'package:electrocardio/screens/screens.dart';
import 'package:flutter/material.dart';

import 'theme/theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: "register",
      routes: {
        "register": (context) => const RegistryScreen(),
        "login": (context) => const LoginScreen(),
      },
      theme: ThemeApp.light,
    );
  }
}
