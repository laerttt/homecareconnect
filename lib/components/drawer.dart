// ignore: unused_import
import 'dart:developer';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:homecareconnect/current_location.dart';
import 'package:homecareconnect/objects/clinic.dart';
import 'package:homecareconnect/pages/log_in_page.dart';
import 'package:homecareconnect/pages/home_page.dart';
import 'package:homecareconnect/pages/medicine_tracker.dart';
import 'package:homecareconnect/pages/profile_page.dart';
import 'package:homecareconnect/pages/upload_file_test.dart';
import 'package:homecareconnect/poly.dart';
import 'package:homecareconnect/pages/home_page.dart';

import '../pages/signup.dart';

class myDrawer extends StatefulWidget {
  final String s;
  myDrawer(this.s, {super.key});

  @override
  State<myDrawer> createState() => _myDrawerState(s);
}

class _myDrawerState extends State<myDrawer> {
  late Color color;
  late String? pageName;

  _myDrawerState(this.pageName);
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
                    onTap: () {
                      Navigator.pop(context);
                      if (this.pageName != 'map') Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeWidget()));
                      // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeWidget()));
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            late final ref = FirebaseDatabase.instance.ref();
                            return FutureBuilder(
                                future: ref.child('clinics').get(),
                                builder: (BuildContext context, AsyncSnapshot<DataSnapshot> snapshot) {
                                  List<Clinic> list = [];
                                  if (!snapshot.hasData)
                                    return Container(
                                      color: Colors.grey,
                                    ); // still loading
                                  final c = snapshot.data;
                                  for (var i in c!.children) {
                                    list.add(Clinic(
                                      i.key,
                                      i.child('Clinic Name').value.toString().trim(),
                                      adress: LatLng(double.parse(i.child('Adress').child('lat').value.toString()), double.parse(i.child('Adress').child('lon').value.toString())),
                                      emails: [],
                                      phoneNumbers: [],
                                      employees: [],
                                    ));
                                  }
                                  return Stack(
                                    children: [
                                      Divider(
                                        indent: (MediaQuery.of(context).size.width / 2) - 30,
                                        endIndent: (MediaQuery.of(context).size.width / 2) - 30,
                                        thickness: 3,
                                      ),
                                      Container(
                                        child: ListView(
                                          children: [
                                            for (var i in list)
                                              ListTile(
                                                  title: Text('${i.clinicName}'),
                                                  onTap: () {
                                                    createPolylines(41.404299, 19.707313, i.adress.latitude, i.adress.longitude);
                                                    // Navigator.pop(context);
                                                  })
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                });

                            // return a widget here (you have to return a widget to the builder)
                          });
                    },
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
                    if (this.pageName == 'filepick') {
                      Navigator.pop(context);
                    } else {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => myTestFilePicker()));
                    }
                  },
                ),
                ListTile(
                  splashColor: Colors.transparent,
                  title: const Text('Map', style: TextStyle(fontWeight: FontWeight.w900), textAlign: TextAlign.left),
                  leading: const Icon(Icons.map, size: 25, color: Colors.white),
                  titleAlignment: ListTileTitleAlignment.center,
                  textColor: Colors.white,
                  onTap: () {
                    if (this.pageName == 'map') {
                      Navigator.pop(context);
                    } else {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeWidget()));
                    }
                  },
                ),
                ListTile(
                  splashColor: Colors.transparent,
                  title: const Text('Signout', style: TextStyle(fontWeight: FontWeight.w900), textAlign: TextAlign.left),
                  leading: const Icon(Icons.map, size: 25, color: Colors.white),
                  titleAlignment: ListTileTitleAlignment.center,
                  textColor: Colors.white,
                  onTap: () {
                    FirebaseAuth.instance.signOut();
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
