import 'package:flutter/material.dart';
import 'package:homecareconnect/components/app_bar.dart';
import 'package:homecareconnect/components/drawer.dart';

class LogInWidget extends StatelessWidget {
  const LogInWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar('Log In'),
      drawer: myDrawer(),
      body: Form(
        // key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  // controller: emailController,
                  decoration: const InputDecoration(border: OutlineInputBorder(), labelText: "Email"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  // controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(border: OutlineInputBorder(), labelText: "Password"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // if (_formKey.currentState!.validate()) {
                      //   // Navigate the user to the Home page
                      // } else {
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     const SnackBar(content: Text('Please fill input')),
                      //   );
                      // }
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}