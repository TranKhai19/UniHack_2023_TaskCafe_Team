import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unihack/bloc/authentication/authentication_bloc.dart';
import 'package:unihack/bloc/indextBloc.dart';
import 'package:unihack/router/auto_router.gr.dart';
import 'package:unihack/screens/authentication/login_screen.dart';
import 'package:unihack/screens/home/_widget/Posts.dart';
import 'package:unihack/screens/home/_widget/headerPost.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _statusController = TextEditingController(text: "");
  String? currentUser = '';
  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);
    final Size size = MediaQuery.of(context).size;
    final double screenWidth = size.width;
    final double screenHeight = size.height;
    final indexBlocData = IndextBlocProvider.of(context);
    final AuthenticationBloc authenticationBloc = indexBlocData.indextBloc.authenticationBloc;
    Future<String> loadData() async {
      //Time load data
      // await Future.delayed(Duration(seconds: 2));
      return 'Loading';
    }
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      bloc: authenticationBloc,
      listener: (context, state){
        print('State home ${state.toString()}');
        if(state is AuthenticationAuthenticated){
          setState(() {
            isAuthentication = true;
            currentUser = state.uid.toString();
          });
          print('currentUser home ${currentUser}');
        }
        else if(state is AuthenticationUnauthenticated){
          setState(() {
            isAuthentication = false;
            currentUser = '';
          });
        }
        else if(state is AuthenticationInitial){

          setState(() {
            isAuthentication = false;
            currentUser = '';
          });
        }
      },
      child: Builder(builder: (context){
        return FutureBuilder<String>(
          future: loadData(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return Scaffold(
                body: Center(
                  //animation loadding
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: Colors.pink,
                    size: 50,
                  ),
                ),
              );
            }
            else if(snapshot.hasError){
              return const Text("");
            }
            else{
              return Scaffold(
                  appBar: AppBar(
                    elevation: 0,
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/logo_ui.png',
                          width: 60,
                          height: 60,
                        ),
                        const Text(
                          'Patet',
                          style: TextStyle(
                            color: Color(0xFF50C1AC),
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w700, // -> Roboto-Light.ttf
                            // fontWeight: FontWeight.w100 // -> Roboto-Thin.ttf
                          ),
                        )
                      ],
                    ),
                    actions: <Widget>[
                      IconButton(
                        icon: const Icon(
                          Icons.add,
                          color: Color.fromARGB(255, 51, 51, 51),
                        ),
                        onPressed: () {
                          // do something
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.search,
                          color: Color.fromARGB(255, 51, 51, 51),
                        ),
                        onPressed: () {
                          // do something
                          context.pushRoute(Search());
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.send,
                          color: Color.fromARGB(255, 51, 51, 51),
                        ),
                        onPressed: () {
                          // do something
                        },
                      ),
                    ],
                    shape: const ContinuousRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        )),
                    
                    leading: null,
                    backgroundColor: Color.fromARGB(255, 255, 255, 255),
                  ),
                  body: SafeArea(
                    minimum: const EdgeInsets.only(left: 0, right: 0, top: 0),
                    child: Stack(
                      children: [
                        Posts(currentUser: currentUser!),
                      ],
                    ),
                  ),
                );
            }
          },
        );
      }),
    );
  }
}