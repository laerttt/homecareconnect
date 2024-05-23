import 'package:firebase_auth/firebase_auth.dart';
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${currentUser?.name.capitalize()} ${currentUser?.surname.toString().capitalize()}',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        (currentUser?.email != null) ? '${currentUser?.email}' : 'No email address',
                        style: TextStyle(fontSize: 13),
                      ),
                      Text(
                        (currentUser?.phoneNumber != null) ? '${currentUser?.phoneNumber}' : 'No phone number',
                        style: TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
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
                    Text((currentUser?.age == null) ? 'Age: N/A' : 'Age: ${currentUser?.getAge()}'),
                    Text((currentUser?.gender == null) ? 'Gender: N/A' : 'Gender:${(currentUser?.getGender()).toString().capitalize()}'),
                    Text((currentUser?.bloodType == null) ? 'Bloodtype: N/A' : 'Bloodtype: ${(currentUser?.getBloodType()).toString().capitalize()}'),
                  ],
                ),
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.edit_square,
                color: Colors.red,
              ),
              title: Text('Edit Profile'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.medication_liquid),
              title: Text('Medicaments'),
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
          color: Color.fromARGB(255, 224, 61, 49),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey,
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
          child: ListTile(
            leading: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            title: Text(
              'Log Out',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
            ),
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
