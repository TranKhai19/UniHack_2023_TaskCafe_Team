import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:unihack/data/repositories/person_repository.dart';
import 'package:uuid/uuid.dart';

@RoutePage()
class Addtask extends StatefulWidget {
  final String id;
  const Addtask({super.key, required this.id});

  @override
  State<Addtask> createState() => _AddtaskState();
}

class _AddtaskState extends State<Addtask> {
  final _titleController = TextEditingController(text: "");
  final _descrectionController = TextEditingController(text: "");
  final _priority = TextEditingController(text: "");
  final _status = TextEditingController(text: "");
  var uuid = Uuid();
  final List<String> items = [
    'Dọn rác',
    'Phân loại rác',
    'Trồng cây',
    'Tái chế rác'
  ];
  String? selectedValue = 'Dọn rác';

  final DocumentReference _eventRef = FirebaseFirestore.instance
      .collection('Event')
      .doc('QvL5BJTrRcIy3V10ctD7'); // tự xử lý phần id document trỏ đến event

  void _addTaskToEvent() {
    final newTask = {
      'title': _titleController.text,
      'description': _descrectionController.text,
      'priority': 1,
      'status': 'IN_PROGRESS',
      'asignTo': ''
    };
    String id = uuid.v4();
    _eventRef.update({
      'task.$id': newTask,
    }).then((result) {
      // Task deleted successfully
      print('Task added successfully');
    }).catchError((error) {
      // Error occurred while deleting the task
      print('Error when adding the task: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        title: Text('Thêm việc ', style: TextStyle(color: Colors.black)),
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
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 0, bottom: 10),
                child: Image.asset(
                  'assets/images/logo_ui.png',
                  width: 246,
                  height: 243,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: _titleController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                        isDense: true,
                        filled: true,
                        hintText: 'Tiêu đề ...',
                        fillColor: Colors.white,
                        prefixIcon: const Icon(
                          Icons.question_answer,
                          color: Color(0xFF50C1AC),
                          size: 22,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                ),
              ),
              Container(
                height:
                    350, // 350 là chiều cao của carousel, 60 là chiều cao của phần chọn ảnh và camera, 150 là tổng chiều cao của các phần trước đó.
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 5, bottom: 5, left: 10, right: 10),
                  child: Container(
                    margin: EdgeInsets.only(bottom: 60),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromARGB(255, 255, 255, 255),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(5),
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    child: TextFormField(
                      controller: _descrectionController,
                      keyboardType: TextInputType.emailAddress,
                      maxLines: null, // Hoặc đặt số lớn, ví dụ: 100
                      decoration: InputDecoration(
                        isDense: true,
                        filled: true,
                        hintText: 'Bạn đang nghĩ gì ?',
                        fillColor: Colors.white,
                        prefixIcon: const Icon(
                          Icons.question_answer,
                          color: Color(0xFF50C1AC),
                          size: 22,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset(-140, -60),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: const Row(
                        children: [
                          Icon(
                            Icons.list,
                            size: 16,
                            color: Colors.yellow,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Expanded(
                            child: Text(
                              'Select Item',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.yellow,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      items: items
                          .map((String item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  overflow: TextOverflow.ellipsis,
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
                        width: 100,
                        padding: const EdgeInsets.only(left: 14, right: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: null,
                          color: Color(0xFF50C1AC),
                          boxShadow: null,
                        ),
                        elevation: 2,
                      ),
                      style: TextStyle(color: Colors.white),
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.arrow_forward_ios_outlined,
                        ),
                        iconSize: 14,
                        iconEnabledColor: Color.fromARGB(255, 255, 255, 255),
                        iconDisabledColor: Colors.grey,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        maxHeight: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Color(0xFF50C1AC),
                        ),
                        offset: const Offset(-20, 0),
                        scrollbarTheme: ScrollbarThemeData(
                          radius: const Radius.circular(40),
                          thickness: MaterialStateProperty.all<double>(6),
                          thumbVisibility:
                              MaterialStateProperty.all<bool>(true),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset(0, -40),
                child: Center(
                  child: ElevatedButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.symmetric(horizontal: 18)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFF50C1AC)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        minimumSize: MaterialStateProperty.all<Size>(
                            const Size(328, 48)),
                      ),
                      onPressed: () {
                        _addTaskToEvent();
                        router.pop(true);
                      },
                      child: const Text(
                        'Tạo việc',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                ),
              )
            ]),
      ),
    );
  }
}
