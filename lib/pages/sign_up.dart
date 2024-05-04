import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:homecareconnect/components/app_bar.dart';
import 'package:homecareconnect/components/text_field.dart';

class signInWidget extends StatelessWidget {
  const signInWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: getAppBar('Sign In'),
      body: SafeArea(
        child: Center(
          child: Column(children: [
            SizedBox(height: 25),
            Image(image: AssetImage('icon/login_icon.png'), width: 85, color: Colors.red),
            SizedBox(height: 25),
            myTextField(hintText: 'Name'),
            SizedBox(height: 25),
            myTextField(hintText: 'Password', obscureText: true),
          ]),
        ),
      ),
    );
  }
}
