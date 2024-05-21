import 'package:flutter/material.dart';

class myBaseButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPressed;
  final IconButton;

  const myBaseButton({
    super.key,
    required this.buttonText,
    this.onPressed,
    this.IconButton = false,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: ElevatedButton(
          child: Text(
            buttonText,
            style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600),
          ),
          onPressed: () {
            onPressed!();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red, // background color
            elevation: 1,
          ),
        ));
  }
}
