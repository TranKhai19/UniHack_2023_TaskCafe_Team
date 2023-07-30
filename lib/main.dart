import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:unihack/bloc/authentication/authentication_bloc.dart';
import 'package:unihack/bloc/indextBloc.dart';
import 'package:unihack/data/repositories/person_repository.dart';
import 'package:unihack/router/auto_router.dart';
import 'firebase_options.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
    final PersonRepository personRepository = PersonRepository();
    final AuthenticationBloc authenticationBloc = AuthenticationBloc(personRepository: personRepository);
    final indextBloc = IndextBloc(authenticationBloc: authenticationBloc);
  runApp(
    IndextBlocProvider(
      data: IndextBlocProviderData(indextBloc),
      child: const MyApp(),
      ),);
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
  // ..customAnimation = CustomAnimation();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appRouter = AppRouter();
  @override           
  Widget build(BuildContext context) {
    return MaterialApp.router( 
      title: 'UniHack',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(                                      
          primaryColor: const Color(0xFF50C1AC),
          brightness: Brightness.light,
          fontFamily: 'Roboto',
          cardTheme: CardTheme(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: Colors.white60,
          )),
      routerConfig: _appRouter.config(),
      builder: EasyLoading.init(),
    );
  }
}
