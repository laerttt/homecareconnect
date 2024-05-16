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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('image placeholder'),
                Column(
                  children: [
                    Text(
                      'name',
                      style: TextStyle(fontSize: 30),
                    ),
                    Text(
                      'surname',
                      style: TextStyle(fontSize: 30),
                    ),
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [Text('age: 24'), Text('data: data'), Text('data: data')],
            ),
            ListTile()
          ],
        ),
      ),
    );
  }

  signOut() {
    FirebaseAuth.instance.signOut();
  }
}
