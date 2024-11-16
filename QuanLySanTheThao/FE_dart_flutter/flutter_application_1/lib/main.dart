import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/logincomponent/login.dart';
import 'package:flutter_application_1/component/logincomponent/sigup.dart';
import 'package:flutter_application_1/component/yartcomponent/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/user/login": (context) => login(),
        "/user/sigup": (context) => sigup(),
        "/user/home": (context) => home(),
      },
      home: login(),
      debugShowCheckedModeBanner: false,
    );
  }
}
