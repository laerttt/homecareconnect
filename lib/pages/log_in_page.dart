import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homecareconnect/components/app_bar.dart';
import 'package:homecareconnect/components/drawer.dart';
import 'package:homecareconnect/components/text_field.dart';
import 'package:homecareconnect/pages/clinic_signup.dart';
import 'package:homecareconnect/pages/signup.dart';

class MyLogInWidget extends StatefulWidget {
  const MyLogInWidget({super.key});
  @override
  State<MyLogInWidget> createState() => _MyLogInWidgetState();
}

class _MyLogInWidgetState extends State<MyLogInWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: myDrawer(),
      appBar: getAppBarBlack('Log In'),
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Center(
          child: Column(children: [
            SizedBox(height: 20),
            Image(image: AssetImage('icon/login_icon.png'), width: 85, color: Colors.red),
            SizedBox(height: 10),
            myTextField(
              hintText: 'E-mail',
              controller: emailController,
            ),
            SizedBox(height: 10),
            myTextField(
              hintText: 'Password',
              controller: passwordController,
              obscureText: true,
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 250,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    icon: Icon(
                      Icons.login,
                      size: 16,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Log In',
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    onPressed: signIn,
                  ),
                ),
              ],
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Register()));
                },
                child: Center(
                  // padding: const EdgeInsets.symmetric(horizontal: 90.0),
                  child: Text(
                    "Register here",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.blue,
                    ),
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }

  signIn() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
              child: CircularProgressIndicator(
            color: Colors.red,
          ));
        });
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
    Navigator.pop(context);
  }
}
