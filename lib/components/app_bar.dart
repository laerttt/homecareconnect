import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

AppBar getAppBar(String title) {
  return AppBar(
    // actions: [
    //   IconButton(
    //     icon: Icon(Icons.logout),
    //     onPressed: () {
    //       FirebaseAuth.instance.signOut();
    //     },
    //   )
    // ],
    iconTheme: IconThemeData(color: Colors.white),
    backgroundColor: Colors.red,
    elevation: 5,
    shadowColor: Colors.black,
    centerTitle: true,
    title: Text(
      title,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w900,
      ),
    ),
  );
}

AppBar getAppBarBlack(String title) {
  return AppBar(
    iconTheme: IconThemeData(color: Colors.white),
    backgroundColor: Colors.red,
    elevation: 0,
    shadowColor: Colors.black,
    centerTitle: true,
    title: Text(
      title,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w900,
        fontSize: 30,
      ),
    ),
  );
}
