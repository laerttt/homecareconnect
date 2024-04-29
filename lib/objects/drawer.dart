import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 116,
            alignment: Alignment.center,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.all(0),
              child: ListTile(
                titleTextStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
                leading: const Icon(
                  Icons.account_circle,
                  color: Colors.white,
                  size: 50,
                ),
                title: const Text('Profile'),
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
          BackdropFilter(
            blendMode: BlendMode.dst,
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              height: 0,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
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
              'Notifications',
              style: TextStyle(fontWeight: FontWeight.w900),
              textAlign: TextAlign.left,
            ),
            textColor: Colors.white,
            onTap: () {},
          )
        ],
      ),
    );
  }
}
