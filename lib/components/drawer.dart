// ignore: unused_import
import 'dart:developer';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:homecareconnect/pages/log_in_page.dart';
import 'package:homecareconnect/pages/home_page.dart';
import 'package:homecareconnect/pages/medicine_tracker.dart';
import 'package:homecareconnect/pages/profile_page.dart';
import 'package:homecareconnect/pages/upload_file_test.dart';

import '../pages/signup.dart';

class myDrawer extends StatefulWidget {
  const myDrawer({super.key});

  @override
  State<myDrawer> createState() => _myDrawerState();
}

class _myDrawerState extends State<myDrawer> {
  late Color color;

  @override
  void initState() {
    super.initState();

    color = Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    double drawer_top_padding = 120;

    return Drawer(
      width: (MediaQuery.of(context).size.width / 2) + 10,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(0),
          bottomRight: Radius.circular(0),
        ),
      ),
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          ClipRect(
            clipBehavior: Clip.hardEdge,
            child: BackdropFilter(
              blendMode: BlendMode.src,
              filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
              child: Container(
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
              ),
            ),
          ),
          Container(
            height: drawer_top_padding,
            alignment: Alignment.center,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.all(0),
              child: ListTile(
                titleTextStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                leading: const Icon(
                  Icons.account_circle,
                  color: Colors.white,
                  size: 50,
                ),
                title: const Text('My Profile'),
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MyProfileWidget()));
                },
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, drawer_top_padding, 0, 0),
            child: ListView(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(color: Colors.red),
                  child: ListTile(
                    splashColor: Colors.transparent,
                    title: const Text(
                      'Contact Doctor',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    titleAlignment: ListTileTitleAlignment.center,
                    leading: const Icon(
                      Icons.local_hospital,
                      size: 25,
                      color: Colors.white,
                    ),
                    textColor: Colors.white,
                    onTap: () {},
                  ),
                ),
                ListTile(
                  splashColor: Colors.transparent,
                  titleAlignment: ListTileTitleAlignment.center,
                  leading: const Icon(
                    Icons.medical_information,
                    size: 25,
                    color: Colors.white,
                  ),
                  title: const Text(
                    'Medicine',
                    style: TextStyle(fontWeight: FontWeight.w900),
                    textAlign: TextAlign.left,
                  ),
                  textColor: Colors.white,
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MedicineTracker()));
                  },
                ),
                ListTile(
                  splashColor: Colors.transparent,
                  titleAlignment: ListTileTitleAlignment.center,
                  leading: const Icon(
                    Icons.notifications,
                    size: 25,
                    color: Colors.white,
                  ),
                  title: const Text(
                    'Notifications',
                    style: TextStyle(fontWeight: FontWeight.w900),
                    textAlign: TextAlign.left,
                  ),
                  textColor: Colors.white,
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Register()));
                  },
                ),
                ListTile(
                  splashColor: Colors.transparent,
                  title: const Text(
                    'Documents',
                    style: TextStyle(fontWeight: FontWeight.w900),
                    textAlign: TextAlign.left,
                  ),
                  leading: const Icon(
                    Icons.edit_document,
                    size: 25,
                    color: Colors.white,
                  ),
                  titleAlignment: ListTileTitleAlignment.center,
                  textColor: Colors.white,
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => myTestFilePicker()));
                  },
                ),
                ListTile(
                  splashColor: Colors.transparent,
                  title: const Text(
                    'Settings',
                    style: TextStyle(fontWeight: FontWeight.w900),
                    textAlign: TextAlign.left,
                  ),
                  leading: const Icon(
                    Icons.settings,
                    size: 25,
                    color: Colors.white,
                  ),
                  titleAlignment: ListTileTitleAlignment.center,
                  textColor: Colors.white,
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MyLogInWidget()));
                  },
                ),
                ListTile(
                  splashColor: Colors.transparent,
                  title: const Text('Map', style: TextStyle(fontWeight: FontWeight.w900), textAlign: TextAlign.left),
                  leading: const Icon(Icons.map, size: 25, color: Colors.white),
                  titleAlignment: ListTileTitleAlignment.center,
                  textColor: Colors.white,
                  onTap: () {
                    if (context == HomeWidget()) {
                    } else {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeWidget()));
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
