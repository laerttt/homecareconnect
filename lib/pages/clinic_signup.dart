import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:homecareconnect/components/app_bar.dart';
import 'package:homecareconnect/components/button.dart';
import 'package:homecareconnect/components/drawer.dart';
import 'package:homecareconnect/components/text_field.dart';
import 'package:homecareconnect/objects/clinic.dart';
import 'package:homecareconnect/pages/home_page.dart';
import 'package:homecareconnect/pages/signup.dart';

class ClinicRegister extends StatefulWidget {
  const ClinicRegister({Key? key}) : super(key: key);

  @override
  State<ClinicRegister> createState() => _RegisterState();
}

class _RegisterState extends State<ClinicRegister> {
  Map userData = {};
  final _formkey = GlobalKey<FormState>();
  final clinicNameController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  FilePickerResult? filesController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: myDrawer(),
        backgroundColor: Colors.grey[100],
        appBar: getAppBar("Sign Up "),
        body: Column(
          children: [
            SizedBox(
              height: 45,
            ),
            Image(image: AssetImage('icon/login_icon.png'), width: 85, color: Colors.red),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                child: Form(
                    key: _formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: myTextField(controller: clinicNameController, hintText: "Enter clinic name"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: myTextField(
                            controller: phoneController,
                            hintText: "Enter your phone number",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: myTextField(controller: emailController, hintText: "Enter clinic email "),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: myTextField(
                            hintText: 'Enter your password',
                            controller: passwordController,
                            obscureText: true,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                                  child: Text(
                                    'Add all available nurses JSON ',
                                    style: TextStyle(color: Colors.grey[500]),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: IconButton(
                                    icon: Icon(Icons.attach_file),
                                    onPressed: () async {
                                      filesController = await FilePicker.platform.pickFiles(
                                        allowMultiple: true,
                                        allowedExtensions: ['json'],
                                      );
                                      if (filesController == null) {
                                        print("No file selected");
                                      } else {
                                        setState(() {});
                                        for (var element in filesController!.files) {
                                          print(element.name);
                                        }
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Center(
                            child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Container(
                            // margin: EdgeInsets.fromLTRB(200, 20, 50, 0),
                            child: myBaseButton(
                              buttonText: "Register",
                              onPressed: () async {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Center(
                                          child: CircularProgressIndicator(
                                        color: Colors.red,
                                      ));
                                    });
                                await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text.trim()).then((u) async {
                                  await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text.trim()).then((c) {
                                    var clinc = Clinic(c.user?.uid, passwordController.text.trim(), emails: ['${emailController.text.trim()}'], phoneNumbers: [phoneController.text.trim()]);
                                    var usr = FirebaseAuth.instance.currentUser;
                                    usr?.updateDisplayName('${clinicNameController.text.trim()}');
                                    clinc.writeClinic();
                                    Navigator.pop(context);
                                  });
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeWidget()));
                                }).catchError(
                                  (e) {
                                    //   showDialog<void>(
                                    //     context: context,
                                    //     barrierDismissible: false, // user must tap button!
                                    //     builder: (BuildContext context) {
                                    //       return AlertDialog(
                                    //         title: const Text('AlertDialog Title'),
                                    //         content: const SingleChildScrollView(
                                    //           child: ListBody(
                                    //             children: <Widget>[
                                    //               Text('This is a demo alert dialog.'),
                                    //               Text('Would you like to approve of this message?'),
                                    //             ],
                                    //           ),
                                    //         ),
                                    //         actions: <Widget>[
                                    //           TextButton(
                                    //             child: const Text('Approve'),
                                    //             onPressed: () {
                                    //               Navigator.of(context).pop();
                                    //             },
                                    //           ),
                                    //         ],
                                    //       );
                                    //     },
                                    //   );
                                    Navigator.pop(context);
                                  },
                                );
                              },
                            ),

                            width: MediaQuery.of(context).size.width,

                            height: 50,
                          ),
                        )),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: GestureDetector(
                            ///Add onTap reroute Si
                            onTap: () {
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Register()));
                            },
                            child: Center(
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 90.0),
                                child: Text(
                                  "Are you a patient?",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.blue,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          ],
        ));
  }
}
