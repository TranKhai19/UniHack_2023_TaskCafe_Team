import 'package:flutter/material.dart';

class ButtonWidget extends StatefulWidget {
  final String title;
  final void Function() onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double textSize;
  final double radiusCircular;
  final Size sizeButton;
  const ButtonWidget({
    super.key,
    required this.backgroundColor,
    required this.textColor,
    required this.title,
    required this.onPressed,
    required this.radiusCircular,
    required this.textSize,
    required this.sizeButton,
  });

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.backgroundColor,
        fixedSize: widget.sizeButton,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.radiusCircular),
        ),
      ),
      onPressed: widget.onPressed,
      child: Text(
        widget.title,
        style: TextStyle(
          fontSize: widget.textSize,
          color: widget.textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}