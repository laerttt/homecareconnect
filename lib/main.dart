import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:homecareconnect/User.dart';
import 'package:homecareconnect/pages/logIn.dart';
import 'firebase_options.dart';

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
    //testing db wrtiting
    log('creating user...');
    User usr = User('99', 'tikitaka',
        name: 'Laert',
        surname: 'Huti',
        gender: 1,
        age: 21,
        address: 'Myslym Shyri');

    // DatabaseReference x = FirebaseDatabase.instance.ref('users/${usr.id}');
    // await x.set(usr.toJson());
    log('out');
    usr.writeUser();
    log('uuuuu');
    usr = User('100', 'takatiki',
        name: 'kelvin',
        surname: 'byca',
        gender: 2,
        age: 21,
        address: 'rruga e u-dhi-shtes');
    usr.writeUser();
    // await ref.set(usr.toString());
    // await ref.set({
    //   'name': 'laert',
    //   'surname': 'huti',
    // });
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LogInWidget(),
    );
  }
}
