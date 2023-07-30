import 'package:flutter/material.dart';

class SignInWithButton extends StatefulWidget {
  final void Function() onPressed;
  final String typeSignIn;
  final String imagePath;
  const SignInWithButton({
    Key? key,
    required this.onPressed,
    required this.imagePath,
    required this.typeSignIn,
  }) : super(key: key);

  @override
  _SignInWithButtonState createState() => _SignInWithButtonState();
}

class _SignInWithButtonState extends State<SignInWithButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.symmetric(horizontal: 16)),
          backgroundColor: MaterialStateProperty.all<Color>(
              const Color.fromARGB(255, 255, 255, 255)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          minimumSize: MaterialStateProperty.all<Size>(const Size(328, 48)),
        ),
        onPressed: widget.onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(widget.imagePath),
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              widget.typeSignIn,
              style: const TextStyle(color: Color(0xFF333333)),
            )
          ],
        ));
  }
}
