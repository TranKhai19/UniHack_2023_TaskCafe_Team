import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:auto_route/annotations.dart';
import 'package:unihack/widgets/Loading/Loading.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../../api/CloudImage.dart';

@RoutePage()
class Tool extends StatefulWidget {
  @override
  _ToolState createState() => _ToolState();
}

class _ToolState extends State<Tool> {
  List<File> selectedImages = []; // List of selected images
  final picker = ImagePicker();
  final CarouselController _controller = CarouselController();
  int _currentIndex = 0;
  final List<String> items = ['event', 'defause'];
  String? selectedValue = 'event'; // Giá trị mặc định khi khởi tạo Dropdown
  final _titleController = TextEditingController(text: "");
  final _locationController = TextEditingController(text: "");
  final _descController = TextEditingController(text: "");
  Future getImages() async {
    final pickedFile = await picker.pickMultiImage(
      imageQuality: 100, // To set quality of images
      maxHeight: 1000, // To set max height of images that you want in your app
      maxWidth: 1000, // To set max width of images that you want in your app
    );
    List<XFile>? xfilePick = pickedFile;

    // If at least 1 image is selected, add all images in selectedImages
    // variable so that we can easily show them in the UI
    if (xfilePick != null && xfilePick.isNotEmpty) {
      setState(() {
        selectedImages = xfilePick.map((file) => File(file.path)).toList();
        _currentIndex =
            0; // Reset current index to 0 when new images are selected
      });
    } else {
      // If no image is selected, show a snackbar saying nothing is selected
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Nothing is selected')));
    }
  }

  Future getCamera() async {
    final pickedFile = await picker.pickMultiImage(
      imageQuality: 100, // To set quality of images
      maxHeight: 1000, // To set max height of images that you want in your app
      maxWidth: 1000, // To set max width of images that you want in your app
    );
    List<XFile>? xfilePick = pickedFile;

    // If at least 1 image is selected, add all images in selectedImages
    // variable so that we can easily show them in the UI
    if (xfilePick != null && xfilePick.isNotEmpty) {
      setState(() {
        selectedImages = xfilePick.map((file) => File(file.path)).toList();
        _currentIndex =
            0; // Reset current index to 0 when new images are selected
      });
    } else {
      // If no image is selected, show a snackbar saying nothing is selected
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Nothing is selected')));
    }
  }

 

  // Rest of your code remains unchanged
  Future pickCamera() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedImage == null) return;

      setState(() {
        var image = File(pickedImage.path);
        selectedImages.add(image); // Thêm image vào mảng selectedImages
      });
      print(this.selectedImages);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future submit() async {
    List<String> filePath = [];
    for (int i = 0; i < selectedImages.length; i++) {
      String? downloadURL =
          await uploadImageToFirebase(selectedImages[i].path as String);
      if (downloadURL != null) {
        filePath.add(downloadURL);
      } else {
        print("Error uploading image.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        title: const Text(
          'Đăng bài',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                submit();
              },
              child: Container(
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  color: Color(0xFFFC865A),
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
                      'Chia sẽ',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              )),
        ],
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          selectedImages.isEmpty
              ? Container(
                  height: 350.0,
                  child: Center(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Đăng tải hình ảnh của bạn',
                            style: TextStyle(color: Colors.grey),
                          )
                        ]),
                  ),
                )
              : Stack(
                  children: <Widget>[
                    CarouselSlider(
                      carouselController: _controller,
                      options: CarouselOptions(
                        aspectRatio: 1.0,
                        height: 350.0,
                        enlargeCenterPage: false,
                        viewportFraction: 1.0,
                        scrollDirection: Axis.horizontal,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                      ),
                      items: selectedImages
                          .map(
                            (item) => Container(
                              margin: const EdgeInsets.all(5.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),
                                child: Image.file(
                                  item,
                                  fit: BoxFit.cover,
                                  width: 1000.0,
                                  height: 350.0,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    Positioned(
                      top: 10.0,
                      right: 10.0,
                      child: Container(
                        width: 42.0,
                        height: 24.0,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: Center(
                            child: Text(
                              '${_currentIndex + 1}/${selectedImages.length}',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFF8F8EC),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: Column(children: [
              Container(
                // padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    ),
                child: Row(
                  children: <Widget>[
                    TextButton(
                        onPressed: () {
                          getImages();
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 10, right: 10, top: 5, bottom: 5),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            color: Color(0xFF50C1AC),
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              Icon(
                                Icons.image,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Chọn ảnh',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        )),
                    TextButton(
                        onPressed: () {
                          pickCamera();
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 10, right: 10, top: 5, bottom: 5),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            color: Color(0xFF50C1AC),
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              Icon(
                                Icons.camera,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Camera',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        )),
                    DropdownButtonHideUnderline(
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
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    // --------------------------Title----------------------
                    if (selectedValue == 'event')
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 5, bottom: 5, left: 10, right: 10),
                        child: Container(
                          child: TextFormField(
                            controller: _titleController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              filled: true,
                              hintText: 'Tên sự kiện của bạn .. ',
                              prefixIcon: const Icon(
                                Icons.person,
                                color: Color(0xFF50C1AC),
                              ),
                              fillColor:
                                  const Color.fromARGB(255, 250, 252, 255),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(50)),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF50C1AC),
                                  width: 2,
                                ),
                              ),
                              enabledBorder: const OutlineInputBorder(
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
                    // ------------------------------------------------
                    if (selectedValue == 'event')
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 0, bottom: 0, left: 10, right: 10),
                        child: Container(
                          child: TextFormField(
                            controller: _locationController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              filled: true,
                              hintText: 'Địa chỉ .. ',
                              prefixIcon: const Icon(
                                Icons.location_on,
                                color: Color(0xFF50C1AC),
                              ),
                              fillColor:
                                  const Color.fromARGB(255, 250, 252, 255),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(50)),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF50C1AC),
                                  width: 2,
                                ),
                              ),
                              enabledBorder: const OutlineInputBorder(
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
                      height: selectedValue == 'event'
                          ? MediaQuery.of(context).size.height -
                              350 -
                              60 -
                              150 -
                              40
                          : MediaQuery.of(context).size.height -
                              350 -
                              150 -
                              30, // 350 là chiều cao của carousel, 60 là chiều cao của phần chọn ảnh và camera, 150 là tổng chiều cao của các phần trước đó.
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 5, bottom: 5, left: 10, right: 10),
                        child: Container(
                          margin: EdgeInsets.only(bottom: 60),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xFF50C1AC),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(5),
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                          child: TextFormField(
                            controller: _descController,
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
                    )
                  ],
                ),
              ),
            ]),
          )
        ]),
      ),
    );
  }
}
