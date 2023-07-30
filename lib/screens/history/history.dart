
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unihack/widgets/Loading/Loading.dart';

import '../../bloc/authentication/authentication_bloc.dart';
import '../../bloc/indextBloc.dart';

@RoutePage()
class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  String? currentUser = '';

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);
    final indexBlocData = IndextBlocProvider.of(context);
    final AuthenticationBloc authenticationBloc =
        indexBlocData.indextBloc.authenticationBloc;
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      bloc: authenticationBloc,
      listener: (context, state) {
        if (state is AuthenticationAuthenticated) {
          setState(() {
            currentUser = state.uid.toString();
          });
          print('currentUser home ${currentUser}');
        } else if (state is AuthenticationUnauthenticated) {
          setState(() {
            currentUser = '';
          });
        } else if (state is AuthenticationInitial) {
          setState(() {
            currentUser = '';
          });
        }
      },
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Event').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading();
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return Text('No data available');
          }
          // final List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
          // You can return your widget here based on the StreamBuilder snapshot
          // For example, return a ListView.builder to display the data from the snapshots
        print(snapshot);
        
       
        final querySnapshot = snapshot.data!;
        final documents = querySnapshot.docs.where((element) => (element.data()as Map)['assignTo'] == '2SBiZkvQeyQZDKch6UCgpV7OETX2');

        List<Map<String, dynamic>> filteredTasks = [];
        documents.forEach((e) {print(e.data());});
       
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
              elevation: 0,
              title: Text('Công việc', style: TextStyle(color: Colors.black)),
            ),
            body: SingleChildScrollView(
                child: Container(
              child: Column(children: [
                Container(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Event dọn rác bãi biển',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            width: 10,
                            height: 10,
                          ),
                          Container(
                            width: 40,
                            height: 3,
                            decoration: BoxDecoration(color: Color(0xFF50C1AC)),
                          )
                        ],
                      ),
                      Text('13/10/2023',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Container(
                  constraints:
                      BoxConstraints(minHeight: 700, minWidth: double.infinity),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25)),
                    color: Color(0xFF50C1AC),

                    // border: Border(
                    //     top: BorderSide(
                    //   width: 2,
                    // )),
                  ),
                  child: Column(
                      // header
                      children: [
                        Row(
                          children: [
                            TextButton(
                                onPressed: () {},
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, top: 5, bottom: 5),
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25)),
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                  alignment: Alignment.center,
                                  child: Row(
                                    children: [
                                      Text(
                                        'Công Việc',
                                        style: TextStyle(
                                            color: Color(0xFF50C1AC),
                                            fontSize: 16),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                )),
                            Transform.translate(
                              offset: Offset(-10, 0),
                              child: TextButton(
                                  onPressed: () {},
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 10, right: 10, top: 5, bottom: 5),
                                    decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(25)),
                                      color: Color.fromARGB(255, 255, 255, 255),
                                    ),
                                    alignment: Alignment.center,
                                    child: Row(
                                      children: [
                                        Text(
                                          'Hoàng thành',
                                          style: TextStyle(
                                              color: Color(0xFF50C1AC),
                                              fontSize: 16),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                            Transform.translate(
                              offset: Offset(-20, 0),
                              child: TextButton(
                                  onPressed: () {},
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 10, right: 10, top: 5, bottom: 5),
                                    decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(25)),
                                      color: Color.fromARGB(255, 255, 255, 255),
                                    ),
                                    alignment: Alignment.center,
                                    child: Row(
                                      children: [
                                        Text(
                                          'Còn lại',
                                          style: TextStyle(
                                              color: Color(0xFF50C1AC),
                                              fontSize: 16),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                          ],
                        ),
                        // ------------------------Start componentas
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(
                              top: 2, bottom: 2, left: 5, right: 5),
                          padding: EdgeInsets.only(
                              left: 10, right: 10, top: 10, bottom: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            color: Colors.white,
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: 5,
                                          bottom: 5,
                                          left: 5,
                                          right: 10),
                                      padding: EdgeInsets.only(
                                          top: 5,
                                          bottom: 5,
                                          left: 10,
                                          right: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25)),
                                        color: Color(0xFFFC865A),
                                      ),
                                      child: Text(
                                        'Task 1',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: Text(
                                        '13/10/2023',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: const Color.fromARGB(
                                                255, 0, 0, 0)),
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 10,
                                  ),
                                  child: Text(
                                    'Investing is important, if not critical, to make your money work for you. Today, I am going to share my few screen on Investment App Concept. What do you think? Let me know in the comment section and dont forget to leave a like to show some support',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    TextButton(
                                        onPressed: () {
                                          //event code is Here
                                        },
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              left: 15,
                                              right: 15,
                                              top: 10,
                                              bottom: 10),
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(25)),
                                            color: Color(0xFFFFDEA4),
                                          ),
                                          alignment: Alignment.center,
                                          child: Row(
                                            children: [
                                              Text(
                                                'Diễn ra',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        )),
                                  ],
                                ),
                                // -----------------End task--------------------
                                
                              ]),
                        ),
                         // ------------------------Start componentas
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(
                              top: 2, bottom: 2, left: 5, right: 5),
                          padding: EdgeInsets.only(
                              left: 10, right: 10, top: 10, bottom: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            color: Colors.white,
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: 5,
                                          bottom: 5,
                                          left: 5,
                                          right: 10),
                                      padding: EdgeInsets.only(
                                          top: 5,
                                          bottom: 5,
                                          left: 10,
                                          right: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25)),
                                        color: Color(0xFFFC865A),
                                      ),
                                      child: Text(
                                        'Task 1',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: Text(
                                        '13/10/2023',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: const Color.fromARGB(
                                                255, 0, 0, 0)),
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 10,
                                  ),
                                  child: Text(
                                    'Investing is important, if not critical, to make your money work for you. Today, I am going to share my few screen on Investment App Concept. What do you think? Let me know in the comment section and dont forget to leave a like to show some support',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    TextButton(
                                        onPressed: () {
                                          //event code is Here
                                        },
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              left: 15,
                                              right: 15,
                                              top: 10,
                                              bottom: 10),
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(25)),
                                            color: Color(0xFFFFDEA4),
                                          ),
                                          alignment: Alignment.center,
                                          child: Row(
                                            children: [
                                              Text(
                                                'Diễn ra',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        )),
                                  ],
                                ),
                                // -----------------End task--------------------
                                
                              ]),
                        ),
                         // ------------------------Start componentas
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(
                              top: 2, bottom: 2, left: 5, right: 5),
                          padding: EdgeInsets.only(
                              left: 10, right: 10, top: 10, bottom: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            color: Colors.white,
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: 5,
                                          bottom: 5,
                                          left: 5,
                                          right: 10),
                                      padding: EdgeInsets.only(
                                          top: 5,
                                          bottom: 5,
                                          left: 10,
                                          right: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25)),
                                        color: Color(0xFFFC865A),
                                      ),
                                      child: Text(
                                        'Task 1',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: Text(
                                        '13/10/2023',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: const Color.fromARGB(
                                                255, 0, 0, 0)),
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 10,
                                  ),
                                  child: Text(
                                    'Investing is important, if not critical, to make your money work for you. Today, I am going to share my few screen on Investment App Concept. What do you think? Let me know in the comment section and dont forget to leave a like to show some support',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    TextButton(
                                        onPressed: () {
                                          //event code is Here
                                        },
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              left: 15,
                                              right: 15,
                                              top: 10,
                                              bottom: 10),
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(25)),
                                            color: Color(0xFFFFDEA4),
                                          ),
                                          alignment: Alignment.center,
                                          child: Row(
                                            children: [
                                              Text(
                                                'Diễn ra',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        )),
                                  ],
                                ),
                                // -----------------End task--------------------
                                
                              ]),
                        ),
                         // ------------------------Start componentas
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(
                              top: 2, bottom: 2, left: 5, right: 5),
                          padding: EdgeInsets.only(
                              left: 10, right: 10, top: 10, bottom: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            color: Colors.white,
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: 5,
                                          bottom: 5,
                                          left: 5,
                                          right: 10),
                                      padding: EdgeInsets.only(
                                          top: 5,
                                          bottom: 5,
                                          left: 10,
                                          right: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25)),
                                        color: Color(0xFFFC865A),
                                      ),
                                      child: Text(
                                        'Task 1',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: Text(
                                        '13/10/2023',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: const Color.fromARGB(
                                                255, 0, 0, 0)),
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 10,
                                  ),
                                  child: Text(
                                    'Investing is important, if not critical, to make your money work for you. Today, I am going to share my few screen on Investment App Concept. What do you think? Let me know in the comment section and dont forget to leave a like to show some support',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    TextButton(
                                        onPressed: () {
                                          //event code is Here
                                        },
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              left: 15,
                                              right: 15,
                                              top: 10,
                                              bottom: 10),
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(25)),
                                            color: Color(0xFFFFDEA4),
                                          ),
                                          alignment: Alignment.center,
                                          child: Row(
                                            children: [
                                              Text(
                                                'Diễn ra',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        )),
                                  ],
                                ),
                                // -----------------End task--------------------
                                
                              ]),
                        ),
                      ]),
                ),
              ]),
            )),
          );
        },
      ),
    );
  }
}
