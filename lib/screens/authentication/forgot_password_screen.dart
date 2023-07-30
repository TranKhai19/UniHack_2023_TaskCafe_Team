import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:unihack/untillize/auth_validator.dart';

@RoutePage()
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController? _email;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController(text: "");
  }

  Future<void> sendGmail(BuildContext context) async {
    EasyLoading.show(status: 'Vui Lòng chờ đợi');
    String? email = _email?.text;
    String? _validateEmail = Validator.validateEmail(email: email);
    if (_validateEmail != null) {
      EasyLoading.showError(_validateEmail);
    } else {
      //  code here prin
      print(email);
    }
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF50C1AC),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // xử lý sự kiện khi người dùng click vào icon back
            router.pop(true);
          },
        ),
        title: const Text(
          'Khôi phục tài khoản',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
      body: SafeArea(
          minimum: const EdgeInsets.only(left: 17, right: 17),
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 200, bottom: 20),
                child: const Center(
                  child: Text(
                    '',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0, bottom: 10),
                child: Container(
                  child: TextFormField(
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => setState(() {}),
                    decoration: InputDecoration(
                      filled: true,
                      hintText: 'Email',
                      prefixIcon: const Icon(
                        Icons.email,
                        color: Color(0xFF50C1AC),
                      ),
                      fillColor: const Color.fromARGB(255, 250, 252, 255),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(50)),
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
              // --------------------------Login----------------------
              ElevatedButton(
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
                    // login(context);
                    sendGmail(context);
                  },
                  child: const Text(
                    'Gửi mã',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
            ],
          )),
    );
  }
}
