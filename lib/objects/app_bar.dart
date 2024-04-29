import 'package:flutter/material.dart';

AppBar getAppBar() {
  return AppBar(
    iconTheme: IconThemeData(color: Colors.white),
    backgroundColor: Colors.red,
    elevation: 10.0,
    shadowColor: Colors.black,
    centerTitle: true,
    title: const Text(
      'Map',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w900,
      ),
    ),
  );
}
