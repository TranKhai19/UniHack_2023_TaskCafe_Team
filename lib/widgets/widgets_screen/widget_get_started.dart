import 'package:flutter/material.dart';

class WidgetsGetStarted extends StatelessWidget {
  const WidgetsGetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 50,
          width: 80,
          height: 180,
          child: Image.asset(
            'assets/images/Start_1.png',
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 10,
          right: 20,
          width: 50,
          height: 120,
          child: Image.asset(
            'assets/images/Start_2.png',
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 105,
          left: 62,
          width: 58,
          height: 66,
          child: Image.asset(
            'assets/images/Start_4.png',
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 50,
          left: 61,
          width: 57,
          height: 66,
          child: Image.asset(
            'assets/images/Start_3.png',
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 115,
          left: 80,
          width: 29,
          height: 41,
          child: Image.asset(
            'assets/images/Start_5.png',
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
