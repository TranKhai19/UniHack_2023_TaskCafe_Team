import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unihack/bloc/authentication/authentication_bloc.dart';
import 'package:unihack/bloc/indextBloc.dart';
import 'package:unihack/data/repositories/person_repository.dart';

import 'package:unihack/router/auto_router.gr.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'authentication/login_screen.dart';

@RoutePage()
class HomeViewScreen extends StatefulWidget {
  const HomeViewScreen({Key? key}) : super(key: key);

  // ignore: unused_field

  @override
  State<HomeViewScreen> createState() => _HomeViewScreenState();
}

int selectedIndex = 0;

class _HomeViewScreenState extends State<HomeViewScreen> {
  bool _isFirstTimeUser = true;
  bool screenIndex = true;
  final _statusController = TextEditingController(text: "");

  Future<void> _checkIfFirstTimeUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTimeUser = prefs.getBool('first_time_user') ?? true;
    setState(() {
      _isFirstTimeUser = isFirstTimeUser;
    });
    if (isFirstTimeUser) {
      prefs.setBool('first_time_user', false);
    }
  }

  late AuthenticationBloc authenticationBloc;
  late PersonRepository personRepository;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final indextBlocData = IndextBlocProvider.of(context);
    personRepository = PersonRepository();
    authenticationBloc = indextBlocData.indextBloc.authenticationBloc;
  }

  @override
  void dispose() {
    authenticationBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color selected = Color(0xFF50C1AC);
    final router = AutoRouter.of(context);
        final indexBlocData = IndextBlocProvider.of(context);
    final AuthenticationBloc authenticationBloc = indexBlocData.indextBloc.authenticationBloc;
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      bloc: authenticationBloc,
      listener: (context, state) {
        print('state view ${state.toString()}');
        if (state is AuthenticationAuthenticated) {
          setState(() {
            isAuthentication = true;
          });
        } else if (state is AuthenticationUnauthenticated) {
          setState(() {
            isAuthentication = false;
          });
        } else if (state is AuthenticationInitial) {
          setState(() {
            isAuthentication = false;
          });
        }
      },
      child: Builder(
        builder: (context) {
          return isAuthentication
              ? AutoTabsRouter.pageView(
                  routes: const [
                    HomeRoute(),
                    Tool(),
                    History(),
                    ProfileRoute(),
                  ],
                  physics: const NeverScrollableScrollPhysics(),
                  builder: (context, child, _) {
                    final tabsRouter = AutoTabsRouter.of(context);
                    void onButtonSelected(int index) {
                      setState(() {
                        selectedIndex = index;
                        screenIndex = tabsRouter.activeIndex == index;
                      });
                      tabsRouter.setActiveIndex(index);
                    }

                    return Scaffold(
                      extendBody: true,
                      body: child,
                      bottomNavigationBar: CurvedNavigationBar(
                        height: 60,
                        index: tabsRouter.activeIndex,
                        backgroundColor: Colors.transparent,
                        buttonBackgroundColor: const Color(0xFF50C1AC),
                        animationCurve: Curves.easeInOut,
                        animationDuration: const Duration(milliseconds: 200),
                        items: <Widget>[
                          Icon(
                            Icons.home,
                            size: 22,
                            color: selectedIndex == 0
                                ? const Color.fromARGB(255, 255, 255, 255)
                                : Colors.grey,
                          ),
                          Icon(
                            Icons.camera,
                            size: 20,
                            color: selectedIndex == 1
                                ? const Color.fromARGB(255, 255, 255, 255)
                                : Colors.grey,
                          ),
                          Icon(
                            Icons.list_alt,
                            size: 20,
                            color: selectedIndex == 2
                                ? const Color.fromARGB(255, 255, 255, 255)
                                : Colors.grey,
                          ),
                          Icon(
                            Icons.person,
                            size: 20,
                            color: selectedIndex == 3
                                ? const Color.fromARGB(255, 255, 255, 255)
                                : Colors.grey,
                          ),
                        ],
                        onTap: onButtonSelected,
                      ),
                    );
                  },
                )
              : AutoTabsRouter.pageView(
                  physics: const NeverScrollableScrollPhysics(),
                  routes: [
                    const HomeRoute(),
                    const Tool(),
                    const History(),
                    LogInRoute(authenticationBloc: authenticationBloc),
                  ],
                  builder: (context, child, _) {
                    final tabsRouter = AutoTabsRouter.of(context);
                    void onButtonSelected(int index) {
                      setState(() {
                        selectedIndex = index;
                        screenIndex = tabsRouter.activeIndex == index;
                      });
                      tabsRouter.setActiveIndex(index);
                    }

                    return Scaffold(
                      extendBody: true,
                      body: child,
                      bottomNavigationBar: CurvedNavigationBar(
                        height: 60,
                        index: tabsRouter.activeIndex,
                        backgroundColor: Colors.transparent,
                        buttonBackgroundColor: const Color(0xFF50C1AC),
                        animationCurve: Curves.easeInOut,
                        animationDuration: const Duration(milliseconds: 200),
                        items: <Widget>[
                          Icon(
                            Icons.home,
                            size: 22,
                            color: selectedIndex == 0
                                ? const Color.fromARGB(255, 255, 255, 255)
                                : Colors.grey,
                          ),
                          Icon(
                            Icons.camera,
                            size: 20,
                            color: selectedIndex == 1
                                ? const Color.fromARGB(255, 255, 255, 255)
                                : Colors.grey,
                          ),
                          Icon(
                            Icons.list_alt,
                            size: 20,
                            color: selectedIndex == 2
                                ? const Color.fromARGB(255, 255, 255, 255)
                                : Colors.grey,
                          ),
                          Icon(
                            Icons.person,
                            size: 20,
                            color: selectedIndex == 3
                                ? const Color.fromARGB(255, 255, 255, 255)
                                : Colors.grey,
                          ),
                        ],
                        onTap: onButtonSelected,
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
