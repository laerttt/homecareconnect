import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:homecareconnect/components/app_bar.dart';
import 'package:homecareconnect/components/drawer.dart';
import 'package:homecareconnect/objects/user.dart' as myUser;
import 'package:homecareconnect/pages/auth_page.dart';
import 'package:homecareconnect/string_extension.dart';

class MyProfileWidget extends StatefulWidget {
  MyProfileWidget({super.key});

  @override
  State<MyProfileWidget> createState() => _MyProfileWidgetState();
}

class _MyProfileWidgetState extends State<MyProfileWidget> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return FutureBuilder(
        future: myUser.toObject(user.uid),
        builder: (BuildContext context, AsyncSnapshot<myUser.User> snapshot) {
          if (!snapshot.hasData) return Container(); // still loading
          // alternatively use snapshot.connectionState != ConnectionState.done
          final myUser.User? currentUser = snapshot.data;
          return profileScaffold(currentUser, context);
          // return a widget here (you have to return a widget to the builder)
        });
  }

  Scaffold profileScaffold(myUser.User? currentUser, BuildContext context) {
    return Scaffold(
      drawer: myDrawer(),
      appBar: getAppBar('My Profile'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Icon(
                        Icons.account_circle,
                        size: 90,
                      )),
                  Text(
                    '${currentUser?.name.capitalize()} ${currentUser?.surname.toString().capitalize()}',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Age: ${currentUser?.getAge()}'),
                    Text('Gender:${(currentUser?.getGender()).toString().capitalize()}'),
                    Text('Blood Type: ${(currentUser?.getBloodType()).toString().capitalize()}'),
                  ],
                ),
              ),
            ),
            Divider(),
            Text((currentUser?.email != null) ? '${currentUser?.email}' : 'No email address'),
            ListTile(
              leading: Icon(Icons.edit_square),
              title: Text('Edit Profile'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.healing_outlined),
              title: Text('Health Issues'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.security),
              title: Text('Allergies'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.edit_document),
              title: Text('Docs'),
              onTap: () {},
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
          child: ListTile(
            leading: Icon(Icons.logout),
            title: Text('Log Out'),
            onTap: () {
              signOut();
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AuthPage()));
            },
          ),
        ),
      ),
    );
  }

  signOut() {
    FirebaseAuth.instance.signOut();
  }
}
