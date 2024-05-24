// ignore: unused_import
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:homecareconnect/objects/clinic.dart';
import 'package:homecareconnect/objects/user.dart';
import 'package:homecareconnect/pages/auth_page.dart';
import 'package:homecareconnect/pages/clinic_main.dart';
import 'package:homecareconnect/pages/clinic_signup.dart';
import 'package:homecareconnect/pages/log_in_page.dart';
import 'package:homecareconnect/pages/medicine_tracker.dart';
import 'package:homecareconnect/pages/profile_page.dart';
import 'package:homecareconnect/pages/signup.dart';
import 'firebase/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    User user = User.testDummy();
    log('${user.gender}');
    user.writeUser();
    Clinic clinic = Clinic.testDummy();
    Clinic clinic1 = Clinic.testDummy1();
    ;
    clinic.writeClinic();
    clinic1.writeClinic();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: Colors.red,
            selectionColor: Colors.red.shade200,
            selectionHandleColor: Colors.red,
          ),
          fontFamily: 'Apple-Gothic',
        ),
        home: AuthPage());
  }
}
