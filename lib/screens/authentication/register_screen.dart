import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:unihack/bloc/authentication/authentication_bloc.dart';
import 'package:unihack/bloc/indextBloc.dart';

import 'package:unihack/data/repositories/person_repository.dart';
import 'package:unihack/router/auto_router.gr.dart';
import 'package:unihack/untillize/auth_validator.dart';
import 'package:unihack/widgets/button/button_create_account.dart';
import 'package:unihack/widgets/button/text_button_signin.dart';

@RoutePage()
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _obscureTextPassWord = true;
  bool _obscureTextConfirmPassWord = true;
//------------------------ controller input fields-----------------------
  TextEditingController? _fullName;
  TextEditingController? _email;
  TextEditingController? _password1;
  TextEditingController? _password2;
  final _formKey = GlobalKey<FormState>();
  bool _checked = false;

  final PersonRepository personRepository = PersonRepository();
  @override
  void initState() {
    super.initState();
    _fullName = TextEditingController(text: "");
    _email = TextEditingController(text: "");
    _password1 = TextEditingController(text: "");
    _password2 = TextEditingController(text: "");
  }

  Future<User?> signUp() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        final User? user = await personRepository.signUp(
          email: _email.toString(),
          password: _password1.toString(),
        );
        if (user != null) {
          print('dang ky thanh cong');
        } else {
          print('dang ky that bai');
        }
        return user;
      } catch (e) {
        print(e.toString());
        return null;
      }
    }
    return null;
  }

  Future<void> register(BuildContext context) async {
    EasyLoading.show(status: 'Vui Lòng chờ đợi');
    String? email = _email?.text;
    String? fullName = _fullName?.text;
    String? password1 = _password1?.text;
    String? password2 = _password2?.text;
    String? _validateFullName = Validator.validateName(name: fullName);
    String? _validateEmail = Validator.validateEmail(email: email);
    String? _validatePassword1 =
        Validator.validatePassword(password: password1);
    String? _validatePassword2 = Validator.validateConfirmPassword(
        password: password1, confirmPassword: password2);
    print({
      "name": fullName,
      "email": email,
      "pass1": password1,
      "pass2": password2,
    });
    if (email == null &&
        fullName == null &&
        password1 == null &&
        password2 == null) {
      EasyLoading.showError('Vui lòng điền from đăng kí');
      return;
    }
    if (_validateEmail != null) {
      EasyLoading.showError(_validateEmail);
    } else if (_validateFullName != null) {
      EasyLoading.showError(_validateFullName);
    } else if (_validatePassword1 != null) {
      EasyLoading.showError(_validatePassword1);
    } else if (_validatePassword2 != null) {
      EasyLoading.showError(_validatePassword2);
    } else {
      print({
        "name": fullName,
      });
    }
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);
    final indexBlocData = IndextBlocProvider.of(context);
    final AuthenticationBloc authenticationBloc = indexBlocData.indextBloc.authenticationBloc;
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
          'Sign Up',
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
      resizeToAvoidBottomInset: false,
      // resizeToAvoidBottomPadding: false,
      body: SafeArea(
          minimum: const EdgeInsets.only(left: 17, right: 17),
          child: SingleChildScrollView(
            reverse: true,
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // cần đổi
                Container(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  width: double.infinity,
                  child: Image.asset(
                    'assets/images/SignIn__1.png',
                    width: 246,
                    height: 243,
                  ),
                ),
                // --------------------------UserName----------------------
                Padding(
                  padding: const EdgeInsets.only(top: 0, bottom: 10),
                  child: Container(
                    child: TextFormField(
                      controller: _fullName,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) => setState(() {}),
                      decoration: InputDecoration(
                        filled: true,
                        hintText: 'Họ và tên ',
                        prefixIcon: const Icon(
                          Icons.person,
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
                // --------------------------Email----------------------
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
                // --------------------------PassWord----------------------
                Padding(
                  padding: const EdgeInsets.only(top: 0, bottom: 10),
                  child: Container(
                    child: TextFormField(
                      // validator: (value) =>_validator ,
                      controller: _password1,
                      keyboardType: TextInputType.visiblePassword,
                      // validator: (value) =>
                      //     Validator.validatePassword(password: value),
                      onChanged: (value) => setState(() {
                        // _passWord = value;
                      }),
                      obscureText: _obscureTextPassWord,
                      decoration: InputDecoration(
                        filled: true,
                        hintText: 'Mật khẩu',
                        prefixIcon: const Icon(
                          Icons.key,
                          color: Color(0xFF50C1AC),
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscureTextPassWord = !_obscureTextPassWord;
                            });
                          },
                          child: Icon(
                            _obscureTextPassWord
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: const Color(0xFF50C1AC),
                          ),
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
                // --------------------------Confirm PassWord----------------------
                Padding(
                  padding: const EdgeInsets.only(top: 0, bottom: 10),
                  child: Container(
                    child: TextFormField(
                      // validator: (value) =>_validator ,
                      controller: _password2,
                      keyboardType: TextInputType.visiblePassword,
                      onChanged: (value) => setState(() {
                        // _passWord = value;
                      }),
                      obscureText: _obscureTextConfirmPassWord,
                      decoration: InputDecoration(
                        filled: true,
                        hintText: 'xác nhận mật khẩu',
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Color(0xFF50C1AC),
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscureTextConfirmPassWord =
                                  !_obscureTextConfirmPassWord;
                            });
                          },
                          child: Icon(
                            _obscureTextConfirmPassWord
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: const Color(0xFF50C1AC),
                          ),
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
                Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      Checkbox(
                        value: _checked,
                        onChanged: (bool? value) {
                          setState(() {
                            _checked = value!;
                          });
                        },
                        focusColor: const Color(0xFF50C1AC),
                        activeColor: const Color(0xFF50C1AC),
                        shape: const ContinuousRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // launchUrl(Uri.parse('https://www.facebook.com/profile.php?id=100012736594723'));
                          setState(() {
                            _checked = !_checked;
                          });
                        },
                        child: const Text(
                          'Tôi đồng ý với điều khoản',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
                // --------------------------Login----------------------
                CreateAccouuntButton(
                  onPressed: () {
                    register(context);
                    signUp();
                    //personRepository.signOut();
                  },
                ),
                // --------------------------Forgot passWord----------------------
                const SizedBox(
                  height: 15,
                ),
                TextButtonSignIn(
                  onTap: () {
                    context.pushRoute( LogInRoute(authenticationBloc: authenticationBloc));
                  },
                )
              ],
            ),
          )),
    );
  }
}
