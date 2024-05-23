import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:homecareconnect/validators.dart';
import 'package:flutter/foundation.dart';
import 'package:homecareconnect/components/app_bar.dart';
import 'package:homecareconnect/components/button.dart';
import 'package:homecareconnect/components/drawer.dart';
import 'package:homecareconnect/components/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:homecareconnect/objects/user.dart' as myUser;
import 'package:homecareconnect/pages/clinic_signup.dart';
import 'package:homecareconnect/pages/home_page.dart';
import 'package:homecareconnect/pages/log_in_page.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  Map userData = {};
  final _formkey = GlobalKey<FormState>();
  final surnameController = TextEditingController();
  final firstNameController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  late var allergenController = TextEditingController();
  final List<String> allergens = [
    'pollen',
    'dust mites',
    'mold spores',
    'pet dander',
    'nuts',
    'dairy',
    'eggs',
    'insect stings',
    'penicillin',
    'shellfish',
    'fish',
    'soy',
    'wheat',
    'sesame seeds',
    'peanuts',
    'tree nuts',
    'almonds',
    'walnuts',
    'cashews',
    'eggs',
    'milk',
    'sulfites',
    'nickel',
    'sunlight (solar urticaria)',
    'cold (cold urticaria)',
    'heat (heat urticaria)',
    'exercise-induced',
    'pollen-food syndrome (oral allergy syndrome)',
    'fragrances',
    'chemicals',
    'cockroach droppings',
    'mold',
    ' poison ivy ',
    'poison oak'
        'nickel,',
    ' cobalt',
    'wool',
    'antibiotics',
    'aspirin',
    'latex ',
    'cosmetics',
    'detergents',
    'pet saliva',
    'dairy products',
    'pine pollen',
    'feathers',
    'gluten',
    'strawberries',
    'kiwi',
    'bananas',
    'avocado',
    'pineapple',
    'mango',
    'papaya',
  ];

  String? _searchingWithQuery;
  late Iterable<Widget> _lastOptions = <Widget>[];

  FilePickerResult? filesController;
  bool isDark = false;
  Iterable<String> search(String query) {
    if (query == '') {
      return const Iterable<String>.empty();
    }
    return allergens.where((String option) {
      return option.contains(query.toLowerCase());
    });
  }

  DateTime ageController = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(context: context, initialDate: ageController, firstDate: DateTime(2015, 8), lastDate: DateTime(2101));
    if (picked != null && picked != ageController) {
      setState(() {
        ageController = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: myDrawer(''),
      backgroundColor: Colors.grey[100],
      appBar: getAppBar("Sign Up "),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 45,
            ),
            Image(image: AssetImage('icon/login_icon.png'), width: 85, color: Colors.red),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: myTextField(controller: firstNameController, hintText: "Enter your first name"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: myTextField(
                        controller: surnameController,
                        hintText: "Enter your last name",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: myTextField(controller: emailController, hintText: "Enter your email "),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: myTextField(
                        hintText: 'Password',
                        controller: passwordController,
                        obscureText: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: myTextField(controller: phoneController, hintText: "Enter your mobile number "),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    //   child: Row(
                    //     children: [
                    //       Expanded(
                    //         child: Padding(
                    //           padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    //           child: Text(
                    //             'Add medical files',
                    //             style: TextStyle(color: Colors.grey[500]),
                    //           ),
                    //         ),
                    //       ),
                    //       Expanded(
                    //         child: Container(
                    //           child: IconButton(
                    //             icon: Icon(Icons.attach_file),
                    //             onPressed: () async {
                    //               filesController = await FilePicker.platform.pickFiles(allowMultiple: true);
                    //               if (filesController == null) {
                    //                 print("No file selected");
                    //               } else {
                    //                 setState(() {});
                    //                 for (var element in filesController!.files) {
                    //                   print(element.name);
                    //                 }
                    //               }
                    //             },
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    //   child: Row(
                    //     children: [
                    //       Expanded(
                    //         child: Padding(
                    //           padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    //           child: Text(
                    //             'Add known allergens',
                    //             style: TextStyle(color: Colors.grey[500]),
                    //           ),
                    //         ),
                    //       ),
                    //       Expanded(
                    //         child: Container(
                    //           child: SearchAnchor(
                    //             isFullScreen: false,
                    //             builder: (BuildContext context, SearchController controller) {
                    //               return IconButton(
                    //                 icon: const Icon(Icons.medical_information_rounded),
                    //                 onPressed: () {
                    //                   controller.openView();
                    //                 },
                    //               );
                    //             },
                    //             suggestionsBuilder: (BuildContext context, SearchController controller) async {
                    //               _searchingWithQuery = controller.text;
                    //               final List<String> options = (search(_searchingWithQuery!)).toList();

                    //               // If another search happened after this one, throw away these options.
                    //               // Use the previous options instead and wait for the newer request to
                    //               // finish.
                    //               if (_searchingWithQuery != controller.text) {
                    //                 return _lastOptions;
                    //               }

                    //               _lastOptions = List<ListTile>.generate(
                    //                 options.length,
                    //                 (int index) {
                    //                   final String item = options[index];
                    //                   return ListTile(
                    //                     onTap: (null

                    //                         ///add on tap for allergens
                    //                         ),
                    //                     title: Text(item),
                    //                   );
                    //                 },
                    //               );

                    //               return _lastOptions;
                    //             },
                    //           ),
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
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
                            if (validateEmail(emailController.text.trim()) == null && validatePassword(passwordController.text.trim()) == null && phoneNumberValidator(emailController.text.trim()) == null) {
                              await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text.trim()).then((u) async {
                                log('${u.user?.email}');
                                await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text.trim()).then((user) {});
                                var user = myUser.User(u.user!.uid, password: passwordController.text.trim(), name: '${firstNameController.text.trim()}', surname: '${surnameController.text.trim()}', phoneNumber: "${phoneController.text.trim()}", email: emailController.text.trim());
                                var usr = FirebaseAuth.instance.currentUser;
                                usr?.updateDisplayName('${firstNameController.text.trim()} ${surnameController.text.trim()}');
                                log(user.id);
                                user.writeUser();
                                Navigator.pop(context);
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
                                  log(e.toString());
                                  Navigator.pop(context);
                                },
                              );
                            } else {
                              if (validateEmail(emailController.text.trim()) != null) {
                                //TODO: #5 incorrect email address pop up
                              } else if (validatePassword(passwordController.text.trim()) == null) {
                                //TODO: #7 incorrect password pop up
                              } else if (phoneNumberValidator(emailController.text.trim()) == null) {
                                //TODO: #8 incorrect phone number pop up
                              }
                            }
                          },
                        ),
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                      ),
                    )),
                    SizedBox(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ClinicRegister()));
                            },
                            child: Container(
                              child: Text(
                                "Are you a clinic?",
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
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MyLogInWidget()));
                            },
                            child: Container(
                              child: Text(
                                "Log in here",
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
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getMessageFromErrorCode(e) {
    switch (e.toString()) {
      case "ERROR_EMAIL_ALREADY_IN_USE":
      case "account-exists-with-different-credential":
      case "email-already-in-use":
        return "Email already used. Go to login page.";
      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
        return "Wrong email/password combination.";
      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
        return "No user found with this email.";
      case "ERROR_USER_DISABLED":
      case "user-disabled":
        return "User disabled.";
      case "ERROR_TOO_MANY_REQUESTS":
      case "operation-not-allowed":
        return "Too many requests to log into this account.";
      case "ERROR_OPERATION_NOT_ALLOWED":
      case "operation-not-allowed":
        return "Server error, please try again later.";

      case "ERROR_INVALID_EMAIL":
      case "invalid-email":
        return "Email address is invalid.";
      default:
        return "Login failed. Please try again.";
    }
  }
}
