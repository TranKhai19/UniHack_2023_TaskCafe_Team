
import 'package:flutter/material.dart';

class CalculateButton extends StatelessWidget {
  final void Function() onPressed;
  const CalculateButton({
    super.key,
    required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF50C1AC),
        minimumSize: const Size(300, 48),
        padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 25),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      child: const Text(
        'Calculate',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}