import 'package:flutter/material.dart';

class myTextField extends StatelessWidget {
  // final controller;
  final String hintText;
  final bool obscureText;
  final controller;

  const myTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.justify,
        obscureText: obscureText,
        // controller: controller,
        decoration: InputDecoration(
          labelText: hintText,
          labelStyle: TextStyle(color: Colors.black),
          hintStyle: TextStyle(color: Colors.grey[500]),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade200)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          fillColor: Colors.white,
          filled: true,
          // filled: true,
        ),
      ),
    );
  }
}
