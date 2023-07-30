import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../router/auto_router.gr.dart';

class HeaderPost extends StatefulWidget {
  const HeaderPost({super.key});

  @override
  State <HeaderPost> createState() =>  HeaderPostState();
}

class  HeaderPostState extends State <HeaderPost> {
  final _statusController = TextEditingController(text: "");
   
  @override
  Widget build(BuildContext context) {
   final router = AutoRouter.of(context);
    return  Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 10.0,
                    color: const Color.fromARGB(255, 231, 231, 231),
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 52,
                    width: 52,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: const Color.fromARGB(255, 212, 212, 212),
                      ),
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Image.asset(
                        'assets/images/vector-users-icon.webp',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 0, bottom: 0, left: 10),
                      child: Container(
                        color: Colors.white,
                        child: TextFormField(
                          controller: _statusController,
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                            setState(() {
                              // Update state based on the changed value
                            });
                          },
                          onTapOutside: (event) {
                            FocusScope.of(context).unfocus();
                          },
                          onTap: () {
                            // code is here
                            context.pushRoute(Post(id: "1"));
                          },
                          decoration: InputDecoration(
                            filled: true,
                            hintText: 'Đăng tải hình ảnh',
                            fillColor: Color.fromARGB(255, 255, 255, 255),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: const Color.fromARGB(255, 212, 212, 212),
                              ),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF50C1AC),
                                width: 2,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 20),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
  }
}