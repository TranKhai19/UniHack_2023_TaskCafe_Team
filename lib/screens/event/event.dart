import 'package:auto_route/annotations.dart' show RoutePage;
import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:unihack/bloc/authentication/authentication_bloc.dart';

import 'package:unihack/data/models/TimeLineDropdown.dart';
import 'package:unihack/data/models/ToolDropdown.dart';
import 'package:unihack/router/auto_router.gr.dart';

import '../../bloc/indextBloc.dart';

@RoutePage()
class Event extends StatefulWidget {
  final String id;

  const Event({super.key, required this.id});

  @override
  State<Event> createState() => _EventState();
}

class _EventState extends State<Event> {
  String? currentUser = '';
  String? UserEvent = '';
  bool showMore = false;
  final DocumentReference _eventRef = FirebaseFirestore.instance
      .collection('Event')
      .doc('QvL5BJTrRcIy3V10ctD7'); // tự xử lý phần id document 
  final List<TimeLineDropdown> items = [
    TimeLineDropdown(
        title: 'Chuẩn bị', icon: Icons.checklist_rtl_sharp, keyword: 'pre'),
    TimeLineDropdown(
        title: 'Sự Kiện', icon: Icons.hub_outlined, keyword: 'pre'),
    TimeLineDropdown(title: 'Tổng kết', icon: Icons.pan_tool, keyword: 'pre'),
  ];
  String? selectedValue = 'Chuẩn bị';

  // ignore: non_constant_identifier_names
  final List<ToolDropdown> Toolitems = [
    ToolDropdown(title: 'Chậu', amount: 2),
    ToolDropdown(title: 'Xô', amount: 2)
  ];
  // ignore: non_constant_identifier_names
  String? ToolselectedValue;
  void handleAddTask() {
    // code add task is here
    
  }
  void  deleteTask(String taskKey){
 _eventRef.update({
      'task.$taskKey': FieldValue.delete(),
    }).then((result) {
      // Task deleted successfully
      print('Task deleted successfully');
    }).catchError((error) {
      // Error occurred while deleting the task
      print('Error deleting task: $error');
    });
  }
  @override
  Widget build(BuildContext context) {
    bool authencation = false;
    final router = AutoRouter.of(context);
    final indexBlocData = IndextBlocProvider.of(context);
    final AuthenticationBloc authenticationBlocEvent =
        indexBlocData.indextBloc.authenticationBloc;

    return StreamBuilder(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, user) {
        return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('Event')
              .doc(widget.id)
              .snapshots(),
          builder: (context, snapshot) {
            DocumentSnapshot<Map<String, dynamic>>? documentSnapshot =
                snapshot.data;
            print(snapshot.data.toString());
            if (documentSnapshot?.exists == null && true)
              return Text('documentSnapshot');

            Map<String, dynamic>? eventData = documentSnapshot?.data();
            Map<String, dynamic>? deliverableData = eventData?['event'];
            Map<String, dynamic>? taskData = eventData?['task'];
            String? refPost = eventData?['refPost'];
            String? userId = eventData?['userId'];
            String? location = eventData?['location'];
            Timestamp? datetimeEndTimestamp =
                deliverableData?['deliverable']['datetimeEnd'];
            Timestamp? datetimeStartTimestamp =
                deliverableData?['deliverable']['datetimeStart'];
            String formattedDateTimeStart = formatDate(datetimeStartTimestamp);
            String formattedDateTimeEnd = formatDate(datetimeEndTimestamp);
            // Convert the map entries to a list to get both keys and values

            List<MapEntry<String, dynamic>>? taskList =
                taskData == null ? [] : taskData.entries.toList();

            // Print the sample data
           
            for (var entry in taskList) {
              String key = entry.key;
              Map<String, dynamic> value = entry.value;
            }

            return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Color.fromARGB(255, 255, 255, 255),
                title: Text('Ngày dọn dẹp môi trường ',
                    style: TextStyle(color: Colors.black)),
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    // xử lý sự kiện khi người dùng click vào icon back
                    router.pop(true);
                  },
                ),
              ),

              body: ListView(
                children: [
                  // Header EVent
                  Container(
                    padding: EdgeInsets.all(5),
                    margin:
                        EdgeInsets.only(top: 5, bottom: 0, left: 5, right: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        StreamBuilder<DocumentSnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('Users')
                              .doc(userId?.trim())
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Container(
                                child: Text('Error: ${snapshot.error}'),
                              );
                            } else if (snapshot.hasData) {
                              var userData = snapshot.data!.data();
                              if (userData is Map) {
                                var fullName = userData['fullName'];
                                var avatar = userData['avatar'];
                                return Container(
                                  padding: EdgeInsets.all(5),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        height: 100.0,
                                        width: 100.0,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1.0,
                                            color: Color.fromARGB(
                                                255, 212, 212, 212),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(60.0),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(60.0),
                                          child: Image.network(
                                            avatar,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10.0),
                                      Text(
                                        'Được tạo bởi',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 12),
                                      ),
                                      SizedBox(width: 5.0),
                                      Text(
                                        fullName,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            }

                            return Container();
                          },
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: const Color(0xFF50C1AC),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  if(location!=null)
                                  Text(
                                    location!,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today,
                                    color: const Color(0xFF50C1AC),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '$formattedDateTimeStart - $formattedDateTimeEnd',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: const Color(0xFF50C1AC),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'LV3',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Body Events
                  Container(
                    // margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 110,
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, top: 5, bottom: 5),
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                                color: Color(0xFF50C1AC),
                              ),
                              alignment: Alignment.center,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.list,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Nhiệm vụ',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 100,
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, top: 5, bottom: 5),
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                                color: Color(0xFF50C1AC),
                              ),
                              alignment: Alignment.center,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.newspaper,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Tin tức',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Container(
                    constraints: BoxConstraints(
                        minHeight: 570, minWidth: double.infinity),
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                           
                                Transform.translate(
                                  offset: Offset(5, 0),
                                  child: TextButton(
                                      onPressed: () {
                                        context.pushRoute(Addtask(id: widget.id));
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                            top: 5,
                                            bottom: 5),
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25)),
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                        ),
                                        alignment: Alignment.center,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.add,
                                              color: Color(0xFF50C1AC),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              'Thêm việc',
                                              style: TextStyle(
                                                  color: Color(0xFF50C1AC)),
                                            ),
                                          ],
                                        ),
                                      )),
                                ),
                              //  Tool

                              DropdownButtonHideUnderline(
                                child: Container(
                                  width: 120,
                                  margin: const EdgeInsets.only(
                                      top: 10, bottom: 10, right: 10, left: 0),
                                  padding: EdgeInsets.only(
                                      left: 5, right: 5, top: 5, bottom: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Color(0xFF50C1AC),
                                  ),
                                  alignment: Alignment.center,
                                  child: DropdownButton2<String>(
                                    isExpanded: true,
                                    hint: const Row(
                                      children: [
                                        Icon(Icons.timer_outlined,
                                            size: 16, color: Color(0xFF50C1AC)),
                                        SizedBox(width: 4),
                                        Expanded(
                                          child: Text(
                                            'Toàn bộ',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF50C1AC),
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    items: items
                                        .map((TimeLineDropdown item) =>
                                            DropdownMenuItem<String>(
                                              value: item.title,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      item.title,
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            Color(0xFF50C1AC),
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ))
                                        .toList(),
                                    value: selectedValue,
                                    onChanged: (String? value) {
                                      setState(() {
                                        selectedValue = value;
                                      });
                                    },
                                    buttonStyleData: ButtonStyleData(
                                      height: 33,
                                      width: 110,
                                      padding: const EdgeInsets.only(
                                          left: 14, right: 14),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        border: null,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        boxShadow: null,
                                      ),
                                      elevation: 0,
                                    ),
                                    style: TextStyle(color: Colors.white),
                                    iconStyleData: const IconStyleData(
                                      icon: Icon(
                                        Icons.keyboard_arrow_down,
                                      ),
                                      iconSize: 20,
                                      iconEnabledColor: Color(0xFF50C1AC),
                                      iconDisabledColor: Colors.grey,
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                      elevation: 0,
                                      maxHeight: 200,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                      ),
                                      offset: const Offset(-20, 0),
                                      scrollbarTheme: ScrollbarThemeData(
                                        radius: const Radius.circular(40),
                                        thickness:
                                            MaterialStateProperty.all<double>(
                                                6),
                                        thumbVisibility:
                                            MaterialStateProperty.all<bool>(
                                                true),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: taskList.length,
                            itemBuilder: (context, index) {
                              String key = taskList[index].key;
                              var value = taskList[index].value;
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(
                                    top: 2, bottom: 2, left: 5, right: 5),
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, top: 10, bottom: 10),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
                                  color: Colors.white,
                                ),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
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
                                              value['title'].toString(),
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          if (userId != user.data?.uid)
                                            TextButton(
                                                onPressed: () {
                                                  deleteTask(key);
                                                },
                                                child: Container(
                                                  height: 30,
                                                  width: 30,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                100)),
                                                    color: Colors.red,
                                                  ),
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.delete,
                                                      size: 18,
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255),
                                                    ),
                                                  ),
                                                )),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: 10,
                                        ),
                                        child: Text(
                                          value['description'].toString(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          TextButton(
                                              onPressed: () {
                                                //event code is Here
                                                
                                              },
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                    top: 5,
                                                    bottom: 5),
                                                decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(25)),
                                                  color: Color(0xFF50C1AC),
                                                ),
                                                alignment: Alignment.center,
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.add,
                                                      color: Colors.white,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      'Tham gia',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                              )),
                                        ],
                                      )
                                    ]),
                              );
                            },
                          )
                        ]),
                  )
                ],
              ),
              // bottomNavigationBar: Padding(
              //   padding: EdgeInsets.all(10),
              //   child: Container(
              //     height: 40,
              //     decoration: BoxDecoration(color: Colors.white),
              //     child: Row(
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       mainAxisAlignment: MainAxisAlignment.end,
              //       children: [
              //         Text(
              //           'bạn muốn tham gia Event?',
              //           style: TextStyle(color: Colors.grey),
              //         ),
              //         TextButton(
              //             onPressed: () {
              //               //event code is Here
              //             },
              //             child: Container(

              //               padding: EdgeInsets.only(left: 10,right: 10),
              //               decoration: const BoxDecoration(
              //                 borderRadius: BorderRadius.all(Radius.circular(25)),
              //                 color: Colors.red,
              //               ),
              //               alignment: Alignment.center,
              //               child:  Text(
              //                     'Từ chối',
              //                     style: TextStyle(color: Colors.white),
              //                   ),
              //             )),
              //         TextButton(
              //             onPressed: () {
              //               //event code is Here
              //             },
              //             child: Container(

              //               padding: EdgeInsets.only(left: 10,right: 10),
              //               decoration: const BoxDecoration(
              //                 borderRadius: BorderRadius.all(Radius.circular(25)),
              //                 color: Color(0xFF50C1AC),
              //               ),
              //               alignment: Alignment.center,
              //               child:  Text(
              //                     'Tham gia',
              //                     style: TextStyle(color: Colors.white),
              //                   ),
              //             )),
              //       ],
              //     ),
              //   ),
              // ),
            );
          },
        );
      },
    );
  }
}

String formatDate(Timestamp? timestamp) {
  if (timestamp == null) return 'N/A';

  DateTime date = timestamp.toDate();
  String formattedDate = DateFormat('dd/MM/yyyy').format(date);
  return formattedDate;
}
