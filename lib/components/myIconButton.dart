import 'package:flutter/material.dart';

class myIconButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPressed;
  final IconButton;

  const myIconButton({
    super.key,
    required this.buttonText,
    this.onPressed,
    this.IconButton= false,


  });




  @override
  Widget build(
      BuildContext context,
      )
  {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),

        child:   IconButton(

          icon: Icon(Icons.attach_file),
          child: Text(
            buttonText,
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
          onPressed: () {
            onPressed!();

          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent, // background color

            elevation: 5,
          ),
        )
    );
  }
}