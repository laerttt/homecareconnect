import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:homecareconnect/components/app_bar.dart';
import 'package:homecareconnect/components/button.dart';
import 'package:homecareconnect/components/drawer.dart';
import 'package:homecareconnect/components/text_field.dart';

class ClinicRegister extends StatefulWidget {
  const ClinicRegister({Key? key}) : super(key: key);

  @override
  State<ClinicRegister> createState() => _RegisterState();
}


class _RegisterState extends State<ClinicRegister> {
  Map userData = {};
  final _formkey = GlobalKey<FormState>();
  final  clinicNameController = TextEditingController();
  final usernameController= TextEditingController();
  final passwordController= TextEditingController();
  final phoneController= TextEditingController();
  final  emailController = TextEditingController();
  FilePickerResult? filesController;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: myDrawer(),
        appBar: getAppBar(
            "Sign Up "
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: myTextField(

                          controller: clinicNameController,
                          hintText: "Enter clinic name"
                      ),
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
                      child: myTextField(
                        /// TODO: Email duplicate check
                          controller: emailController,
                          hintText: "Enter clinic email "
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),

                      child:   myTextField(
                        hintText: 'Enter your password',
                        controller: passwordController,
                        obscureText: true,
                      ),
                    ),



                    Padding(
                      padding:  const EdgeInsets.symmetric(horizontal: 25.0),


                      child: Row(
                        children: [
                          Expanded(



                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25.0),

                              child: Text(
                                'Add all available nurses JSON ',
                                style:TextStyle(color: Colors.grey[500]) ,

                              ),
                            ),
                          ),

                          Expanded(

                            child: Container(

                              child: IconButton(
                                icon: Icon(Icons.attach_file),

                                onPressed: () async {
                                  filesController =
                                  await FilePicker.platform.pickFiles(allowMultiple: true,
                                    allowedExtensions: ['json'],);
                                  if ( filesController== null) {
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
                          )
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

                              //onPressed: func;
                              /// method for register here
                            ),

                            width: MediaQuery.of(context).size.width,

                            height: 50,
                          ),

                        )
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: GestureDetector(
                        ///Add onTap reroute Si
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 90.0),
                          child: Text(
                            "Are you a patient?",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),


                    ),


                  ],
                )),
          ),
        ));


  }
}

