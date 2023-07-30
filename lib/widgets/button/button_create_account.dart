import 'package:flutter/material.dart';

class CreateAccouuntButton extends StatelessWidget{
  final void Function() onPressed;
  const CreateAccouuntButton({
    super.key,
    required this.onPressed
});
  @override
  Widget build(BuildContext context){
    return ElevatedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.symmetric(horizontal: 18)),
          backgroundColor: MaterialStateProperty.all<Color>(
              const Color(0xFF50C1AC)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          minimumSize:
          MaterialStateProperty.all<Size>(const Size(328, 48)),
        ),
        onPressed: () {
        },
        child: const Text(
          'Tạo tài khoản',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ));
  }
}