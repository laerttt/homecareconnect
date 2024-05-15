import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homecareconnect/components/app_bar.dart';
import 'package:homecareconnect/components/text_field.dart';

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
                  width: MediaQuery.of(context).size.width / 2 - 35,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(),
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
                SizedBox(width: 20),
                // SizedBox(
                //   width: MediaQuery.of(context).size.width / 2 - 35,
                //   child: ElevatedButton.icon(
                //     style: ElevatedButton.styleFrom(
                //       foregroundColor: Colors.black,
                //       backgroundColor: Colors.white,
                //       shape: RoundedRectangleBorder(),
                //     ),
                //     icon: Icon(Icons.login, size: 16),
                //     label: Text(
                //       'Sign In',
                //       style: TextStyle(
                //         fontSize: 17,
                //         color: Colors.black,
                //       ),
                //     ),
                //     onPressed: signIn,
                //   ),
                // ),
              ],
            ),
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
