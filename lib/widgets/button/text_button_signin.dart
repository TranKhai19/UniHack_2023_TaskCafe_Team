import 'package:flutter/material.dart';

class TextButtonSignIn extends StatelessWidget{
  final void Function() onTap;
  const TextButtonSignIn({
    super.key,
    required this.onTap,
});
  @override
  Widget build (BuildContext context){
    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: GestureDetector(
        onTap:onTap,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Bạn đã có tài khoản ?',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              SizedBox(width: 5),
              Text(
                'Đăng Nhập',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF50C1AC)),
              )
            ]),
      ),
    );
  }
}