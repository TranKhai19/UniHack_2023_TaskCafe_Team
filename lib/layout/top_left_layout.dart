import 'package:flutter/material.dart';

class TopLeftLayout extends StatelessWidget {
  const TopLeftLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 188,
          height: 188,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          width: 188,
          height: 80,
          child: Image.asset(
            'assets/images/layout_1.png',
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          width: 100,
          height: 171,
          child: Image.asset(
            'assets/images/layout_2.png',
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
