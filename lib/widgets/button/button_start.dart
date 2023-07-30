
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class StartButton extends StatelessWidget {
  const StartButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.router.navigateNamed('/home');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF50C1AC),
        padding: const EdgeInsets.only(bottom: 0),
        minimumSize: Size(MediaQuery.of(context).size.width,48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      child: const Text(
        'Start',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
