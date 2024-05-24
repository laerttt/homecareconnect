import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:homecareconnect/components/drawer.dart';
import 'package:homecareconnect/objects/clinic.dart';
import 'package:homecareconnect/pages/clinic_main.dart';
import 'package:homecareconnect/pages/home_page.dart';
import 'package:homecareconnect/pages/log_in_page.dart';

class AuthPage extends StatelessWidget {
  AuthPage({super.key});
  final ref = FirebaseDatabase.instance.ref();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ref.get(),
        builder: (BuildContext context, AsyncSnapshot<DataSnapshot> snapshot) {
          if (!snapshot.hasData) return Container(); // still loading
          // alternatively use snapshot.connectionState != ConnectionState.done
          final DataSnapshot? snap = snapshot.data;
          return authScaffold(snap);
          // return a widget here (you have to return a widget to the builder)
        });
  }

  Scaffold authScaffold(DataSnapshot? snap) {
    return Scaffold(
      drawer: myDrawer('auth'),
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snap!.exists) {
              for (var i in snap.child('users').children) {
                if (i.key == snapshot.data?.uid) return HomeWidget();
              }
              for (var i in snap.child('clinics').children) {
                if (i.key == snapshot.data?.uid) return clinic_main();
              }
            }
            return MyLogInWidget();
          }),
    );
  }
}
