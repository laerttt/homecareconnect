import 'package:flutter/material.dart';

AppBar getAppBar(String title) {
  return AppBar(
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
