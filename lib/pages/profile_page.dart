import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homecareconnect/components/app_bar.dart';
import 'package:homecareconnect/components/drawer.dart';

class MyProfileWidget extends StatelessWidget {
  const MyProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      drawer: myDrawer(),
      appBar: getAppBar('Profili im'),
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
                    'John Doe',
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
                    Text('Age: 24'),
                    Text('Gender: Male'),
                    Text('Blood Type: A+'),
                  ],
                ),
              ),
            ),
            Divider(),
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
            onTap: () {},
          ),
        ),
      ),
    );
  }

  signOut() {
    FirebaseAuth.instance.signOut();
  }
}
