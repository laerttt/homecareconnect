import 'package:flutter/material.dart';

class myTextField extends StatelessWidget {
  // final controller;
  final String hintText;
  final bool obscureText;

  const myTextField({super.key, required this.hintText, this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.justify,
        cursorColor: Colors.red,
        cursorHeight: 20,
        obscureText: obscureText,
        // controller: controller,
        decoration: InputDecoration(
          hintStyle: TextStyle(height: 0.5, textBaseline: TextBaseline.ideographic),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade700, width: 1), borderRadius: BorderRadius.all(Radius.circular(5))),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 1), borderRadius: BorderRadius.all(Radius.circular(10))),
          fillColor: Colors.grey.shade200,
          // filled: true,
        ),
      ),
    );
  }
}
