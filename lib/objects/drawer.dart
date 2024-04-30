import 'dart:developer';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:homecareconnect/objects/app_bar.dart';

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
      backgroundColor: Color.fromRGBO(0, 0, 0, 0.1),
      width: (MediaQuery.of(context).size.width / 2) + 10,
      elevation: 5.0,
      // shadowColor: Colors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(0),
          bottomRight: Radius.circular(0),
        ),
      ),
      child: Stack(
        children: <Widget>[
          BackdropFilter(
            blendMode: BlendMode.dst,
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              height: 0,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
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
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
                leading: const Icon(
                  Icons.account_circle,
                  color: Colors.white,
                  size: 50,
                ),
                title: const Text('Profili im'),
                onTap: () {},
              ),
              // Text(
              //   'Get User Name',
              //   style: TextStyle(
              //     color: Colors.black,
              //     fontWeight: FontWeight.w900,
              //     fontSize: 30,
              //   ),
              // ),
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
                    title: const Text(
                      'Kontakto mjekun',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                        backgroundColor: Colors.red,
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
                  subtitle: Text('Nderrimi i veshkes...'),
                  titleAlignment: ListTileTitleAlignment.center,
                  leading: const Icon(
                    Icons.notifications,
                    size: 25,
                    color: Colors.white,
                  ),
                  title: const Text(
                    'Njoftime',
                    style: TextStyle(fontWeight: FontWeight.w900),
                    textAlign: TextAlign.left,
                  ),
                  textColor: Colors.white,
                  onTap: () {},
                ),
                ListTile(
                  title: const Text(
                    'Dokumenta',
                    style: TextStyle(fontWeight: FontWeight.w900),
                    textAlign: TextAlign.left,
                  ),
                  subtitle: const Text('Analizë gjaku...'),
                  leading: const Icon(
                    Icons.edit_document,
                    size: 25,
                    color: Colors.white,
                  ),
                  titleAlignment: ListTileTitleAlignment.center,
                  textColor: Colors.white,
                  onTap: () {},
                ),
                ListTile(
                  title: const Text(
                    'Baza',
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
                  onTap: () {},
                ),
                ListTile(
                  subtitle: Text('Nderrimi i veshkes...'),
                  titleAlignment: ListTileTitleAlignment.center,
                  leading: const Icon(
                    Icons.notifications,
                    size: 25,
                    color: Colors.white,
                  ),
                  title: const Text(
                    'Njoftime',
                    style: TextStyle(fontWeight: FontWeight.w900),
                    textAlign: TextAlign.left,
                  ),
                  textColor: Colors.white,
                  onTap: () {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
