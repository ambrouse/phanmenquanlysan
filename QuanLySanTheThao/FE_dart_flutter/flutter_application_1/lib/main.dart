import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/logincomponent/login.dart';
import 'package:flutter_application_1/component/logincomponent/sigup.dart';
import 'package:flutter_application_1/component/usercomponent/complaint.dart';
import 'package:flutter_application_1/component/usercomponent/edituser.dart';
import 'package:flutter_application_1/component/usercomponent/userprofile.dart';
import 'package:flutter_application_1/component/usercomponent/userrentyard.dart';
import 'package:flutter_application_1/component/yartcomponent/detailyard.dart';
import 'package:flutter_application_1/component/yartcomponent/home.dart';
import 'package:flutter_application_1/component/yartcomponent/listyard.dart';
import 'package:flutter_application_1/component/yartcomponent/paymentrenyard.dart';

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
        "/user/list_yard": (context) => Listyard(),
        "/user/detail_yard": (context) => DetailYard(),
        "/user/payment": (context) => Paymentrenyard(),
        "/user/user_profile": (context) => Userprofile(),
        "/user/user_edit": (context) => Edituser(),
        "/user/user_rent_yard": (context) => Userrentyard(),
        "/user/user_complaint": (context) => Complaint(),
      },
      home: login(),
      debugShowCheckedModeBanner: false,
    );
  }
}
