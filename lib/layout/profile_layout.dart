import 'package:flutter/material.dart';
class ProfileLayout extends StatelessWidget{
  const ProfileLayout({super.key});

  @override
  Widget build(BuildContext context){
    return Stack(
      children: [
        Container(
          width: 300,
          height: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          width: 200,
          height: 200,
          child: Image.asset(
            'assets/images/Profile_Ellipse.png',
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          width: 200,
          height: 200,
          child: Image.asset(
            'assets/images/Profile_Ellipse.png',
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}