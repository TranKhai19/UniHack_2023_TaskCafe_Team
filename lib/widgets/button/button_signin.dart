import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  final void Function() onPressed;
  const SignInButton({
    super.key,
    required this.onPressed,
  });
  @override
    Widget build(BuildContext context){
  return ElevatedButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(
            const EdgeInsets.symmetric(horizontal: 18)),
        backgroundColor:
        MaterialStateProperty.all<Color>(const Color(0xFF50C1AC)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        minimumSize: MaterialStateProperty.all<Size>(const Size(328, 48)),
      ),
      onPressed:onPressed,
      child: const Text(
        'SigIn',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ));
  }
}