import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unihack/bloc/authentication/authentication_bloc.dart';
import 'package:unihack/data/models/person.dart';
import 'package:unihack/layout/profile_layout.dart';

import 'package:unihack/widgets/widgets_screen/widget_profile.dart';

import '../../data/repositories/person_repository.dart';
import '../../router/auto_router.gr.dart';
import '../../widgets/button/button.dart';
import '../authentication/login_screen.dart';
import '../home_view_screen.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController _displayNameController = TextEditingController();
  late TextEditingController _fullNameController = TextEditingController();
  late TextEditingController _emailController = TextEditingController();
  late TextEditingController _photoUrlController = TextEditingController();
  bool isEditing = false;

  @override
  void initiState() {
    super.initState();
    _displayNameController = TextEditingController(text: '123');
    _fullNameController = TextEditingController(text: '456');
    _emailController = TextEditingController(text: '789');
    _photoUrlController = TextEditingController(text: '1011123');
  }

  @override
  void dispose() {
    super.dispose();
  }

  PersonRepository personRepository = PersonRepository();
  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);
    final Size size = MediaQuery.of(context).size;
    final double screenWidth = size.width;
    final double screenHeight = size.height;

    final AuthenticationBloc authenticationBloc = AuthenticationBloc(personRepository: personRepository);
    return Scaffold(
      body: Center(
        child: ButtonWidget(
          sizeButton: const Size(150, 50),
          backgroundColor: Colors.white,
          textSize: 18,
          onPressed: () {
            personRepository.signOut().then((_) {
              context.pushRoute( HomeRoute());
              isAuthentication = false;
              selectedIndex = 0;
              print('Thanh Cong');
            }).catchError((error) {
              // print(error);
            });
          },
          radiusCircular: 24,
          title: 'LogOut',
          textColor: Colors.black,
        ),
      ),
    );
   
  }
}