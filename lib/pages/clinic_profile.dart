import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homecareconnect/components/app_bar.dart';
import 'package:homecareconnect/components/drawer.dart';
import 'package:homecareconnect/objects/user.dart' as myUser;
import 'package:homecareconnect/pages/auth_page.dart';
import 'package:homecareconnect/string_extension.dart';

import '../objects/clinic.dart';
import '../objects/nurse.dart';

class MyProfileWidget extends StatefulWidget {
  MyProfileWidget({super.key});

  @override
  State<MyProfileWidget> createState() => _MyClinicProfile();
}

class _MyClinicProfile extends State<MyProfileWidget> {
  TextEditingController name= new TextEditingController();
  TextEditingController surname= new TextEditingController();
  TextEditingController clinicID= new TextEditingController();
  TextEditingController age= new TextEditingController();
  TextEditingController Email= new TextEditingController();
  TextEditingController PhoneNumber= new TextEditingController();
  TextEditingController License= new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final clinic = FirebaseAuth.instance.currentUser!;
    print("after");
    return FutureBuilder(
        future: Clinic.toObject(clinic.uid),
        builder: (BuildContext context, AsyncSnapshot<Clinic> snapshot) {
          if (!snapshot.hasData) return Container(); // still loading
          // alternatively use snapshot.connectionState != ConnectionState.done
          final Clinic? clinic = snapshot.data;
          print('PRINTCHECK');
          print(clinic);

          print(clinic);

          return profileScaffold(clinic!, context);
          // return a widget here (you have to return a widget to the builder)
        });
  }

  Scaffold profileScaffold(Clinic clinic,BuildContext context) {
    return Scaffold(
      drawer: myDrawer('pfp'),
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
                        '${clinic?.clinicName?.capitalize()} ${clinic?.clinicID.toString().capitalize()}',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        (clinic?.adress != null) ? '${clinic?.emails[1]}' : 'No email address',
                        style: TextStyle(fontSize: 13),
                      ),
                      Text(
                        (clinic?.phoneNumbers[1] != null) ? '${clinic?.phoneNumbers[1]}' : 'No phone number',
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

              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.edit_square,
                color: Colors.red,
              ),
              title: Text('Add nurse'),
              onTap: () {
                _displayDialog(clinic);

                ;
              },
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
  _displayDialog(Clinic clinic) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            elevation: 6,
            backgroundColor: Colors.transparent,
            child: _DialogWithTextField(context,clinic),
          );
        });
  }
  Widget _DialogWithTextField(BuildContext context,Clinic clinic) => Container(
    height: 360,
    decoration: BoxDecoration(
      color: Colors.white,
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    child: Column(
      children: <Widget>[
        SizedBox(height: 24),
        Text(
          "Enter new nurse information",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        SizedBox(height: 10),
        Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10, right: 15, left: 15),
            child: TextFormField(
              controller: name,
              maxLines: 1,
              autofocus: false,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Enter nurse name",
                labelStyle: TextStyle(color: Colors.black),
                hintStyle: TextStyle(color: Colors.grey[500]),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade200)),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                fillColor: Colors.white,
                filled: true,
                // filled: true,
              ),
            )),
        Container(
          width: 150.0,
          height: 1.0,
          color: Colors.grey[400],
        ),
        Padding(
            padding: EdgeInsets.only(top: 10, right: 15, left: 15),
            child: TextFormField(
              controller: surname,
              maxLines: 1,
              autofocus: false,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Enter nurse surname',
                labelStyle: TextStyle(color: Colors.black),
                hintStyle: TextStyle(color: Colors.grey[500]),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade200)),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                fillColor: Colors.white,
                filled: true,
              ),
            )),
        Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10, right: 15, left: 15),
            child: TextFormField(
              controller: PhoneNumber,
              maxLines: 1,
              autofocus: false,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Enter nurse phone number",
                labelStyle: TextStyle(color: Colors.black),
                hintStyle: TextStyle(color: Colors.grey[500]),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade200)),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                fillColor: Colors.white,
                filled: true,
                // filled: true,
              ),
            )),
        Container(
          width: 150.0,
          height: 1.0,
          color: Colors.grey[400],
        ),
        Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10, right: 15, left: 15),
            child: TextFormField(
              controller: Email,
              maxLines: 1,
              autofocus: false,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Enter nurse email",
                labelStyle: TextStyle(color: Colors.black),
                hintStyle: TextStyle(color: Colors.grey[500]),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade200)),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                fillColor: Colors.white,
                filled: true,
                // filled: true,
              ),
            )),
        Container(
          width: 150.0,
          height: 1.0,
          color: Colors.grey[400],
        ),
        Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10, right: 15, left: 15),
            child: TextFormField(
              controller: age,
              maxLines: 1,
              autofocus: false,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Enter nurse age",
                labelStyle: TextStyle(color: Colors.black),
                hintStyle: TextStyle(color: Colors.grey[500]),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade200)),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                fillColor: Colors.white,
                filled: true,
                // filled: true,
              ),
            )),
        Container(
          width: 150.0,
          height: 1.0,
          color: Colors.grey[400],
        ),

        Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10, right: 15, left: 15),
            child: TextFormField(
              controller: License,
              maxLines: 1,
              autofocus: false,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Enter license tag",
                labelStyle: TextStyle(color: Colors.black),
                hintStyle: TextStyle(color: Colors.grey[500]),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade200)),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                fillColor: Colors.white,
                filled: true,
                // filled: true,
              ),
            )),
        Container(
          width: 150.0,
          height: 1.0,
          color: Colors.grey[400],
        ),

        SizedBox(height: 10),

        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(width: 8),
            ElevatedButton(
              child: Text(
                "Save".toUpperCase(),
                style: TextStyle(
                  color: Colors.redAccent,
                ),
              ),
              onPressed: () {
                /// TODO add method to save medicaments
                Nurse newNurse= new Nurse("13",name:name.toString().trim(),surname: surname.toString().trim(),age:age as int,email: Email.toString().trim(),gender: "Male",license: License.toString().trim(),phoneNumber: PhoneNumber.toString().trim());
                clinic.employees?.add(newNurse);
                clinic.writeClinic(update: true);
                // return Navigator.of(context).pop(true);
              },
            )
          ],
        ),
      ],
    ),
  );

  signOut() {
    FirebaseAuth.instance.signOut();
  }
}
