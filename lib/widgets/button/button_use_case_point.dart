import 'package:flutter/material.dart';

class UseCasePointButton extends StatelessWidget {
  final void Function() onPressed;
  const UseCasePointButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double screenWidth = size.width;
    final double screenHeight = size.height;
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        side: BorderSide.none,
        padding: const EdgeInsets.all(0),
        minimumSize: const Size(300, 200),
        elevation: 0,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: SizedBox(
          width: screenWidth - 30,
          height: screenHeight / 2.8,
          child: Stack(
            children: [
              Positioned(
                right: 0,
                top: 0,
                child: Image.asset(
                  'assets/images/button_use_case_calculate_1.png',
                  width: 100,
                  height: 100,
                ),
              ),
              Positioned(
                right: -60,
                bottom: -60,
                child: Image.asset(
                  'assets/images/button_use_case_calculate_2.png',
                  width: 250,
                  height: 250,
                ),
              ),
              Positioned(
                left: 0,
                top: -20,
                child: Image.asset(
                  'assets/images/button_use_case_calculate_3.png',
                  width: 250,
                  height: 250,
                ),
              ),
              const Positioned(
                bottom: 50,
                left: 25,
                child: Text(
                  'Use Case\nCalculator',
                  style: TextStyle(
                    shadows: <Shadow>[
                      Shadow(
                        blurRadius: 10,
                        color: Color.fromRGBO(218, 218, 218, 0.8),
                        offset: Offset(5, 5),
                      )
                    ],
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
