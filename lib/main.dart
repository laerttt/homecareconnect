import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:homecareconnect/User.dart';
import 'package:homecareconnect/pages/logIn.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //testing db wrtiting
  User usr = User(name: 'Laert', surname: 'Huti', age: 21);
  DatabaseReference ref = FirebaseDatabase.instance.ref("users/" + usr._id);
  await ref.set(usr.toJson());
  await ref.set({
    "name": "John",
    "age": 18,
    "address": {"line1": "100 Mountain View"}
  });
  // await ref.set(usr.toString());
  // await ref.set({
  //   'name': 'laert',
  //   'surname': 'huti',
  // });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LogInWidget(),
    );
  }
}
