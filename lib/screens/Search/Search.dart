import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../widgets/PostItem/PostItem.dart';

@RoutePage()
class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final _SearchController = TextEditingController(text: "");
  String keyWords = '';
  Future<void> _postData() async {
    String apiUrl = 'http://172.16.255.193:5005/model/parse';
    Map<String, String> headers = {"Content-Type": "application/json"};

    String text = _SearchController.text;
    Map<String, dynamic> data = {
      "text": text,
    };

    try {
      // Gửi POST request đến API với dữ liệu là JSON đã được encode
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(data),
      );

      // Kiểm tra mã trạng thái của response
      if (response.statusCode == 200) {
        // Nếu request thành công, xử lý dữ liệu từ response ở đây (nếu cần)
        print('POST request thành công');
        print('Response: ${response.body}');
        // Decode JSON response để có thể sử dụng dữ liệu
        Map<String, dynamic> responseData = jsonDecode(response.body);
        // Trích xuất giá trị của trường "name" trong "intent"
        String intentName = responseData['intent']['name'];
        print('Tên intent: $intentName');
        setState(() {
          keyWords = intentName;
        });
      } else {
        // Nếu request không thành công, xử lý lỗi ở đây (nếu cần)
        print('POST request không thành công');
        print('Mã lỗi: ${response.statusCode}');
        print('Lỗi: ${response.body}');
      }
    } catch (e) {
      // Xử lý lỗi trong quá trình gọi API
      print('Lỗi khi gọi API: $e');
    }
  }

  submit() {
    _postData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        title: Text('Tìm kiếm nội dung phù hợp',
            style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            context.popRoute(true);
          },
        ),
      ),
      body: SingleChildScrollView(
          child: StreamBuilder(
              stream: FirebaseAuth.instance.userChanges(),
              builder: (context, user) {
                return StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Post')
                      .where('tag', isEqualTo: keyWords)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var posts = snapshot.data!.docs;
                      print(posts);
                      for (int i = 0; i < posts.length; i++) {
                        print('----------------------------------');
                        print(posts[i].data());
                      }
                      print('---------------ssssssssssssssssssssss');
                      return Column(children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            controller: _SearchController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              isDense: true,
                              filled: true,
                              hintText: 'Tiêu đề ...',
                              hintStyle: TextStyle(
                                  fontSize: 20.0,
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255)),
                              fillColor: Color(0xFF9FE5D8),
                              suffixIcon: IconButton(
                                  icon: const Icon(
                                    Icons.search,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    size: 22,
                                  ),
                                  onPressed: () {
                                    submit();
                                  }),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100)),
                              ),
                            ),
                          ),
                        ),
                        ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: posts.length,
                          itemBuilder: (context, index) {
                            var data =
                                posts[index].data() as Map<String, dynamic>;
                                print('---------------Priiiiiiiiiiiiii');
                                print(data);
                            String? text = data['content'] as String?;
                            List<String>? images =
                                (data['Images'] as List<dynamic>?)
                                    ?.map((e) => e as String)
                                    .toList();
                            String? userId = data['userId'] as String?;
                            String? RefEvent = data['RefEvent'] as String?;
                            bool like = (data['likes'] as int?) == 1;
                            String pid = posts[index].id;

                            List<String>? refComments =
                                (data['RefComment'] as List<dynamic>?)
                                    ?.map((e) => e as String)
                                    .toList();
                            refComments?.reversed.toList();
                            List<String>? refUsers =
                                (data['RefUsers'] as List<dynamic>?)
                                    ?.map((e) => e as String)
                                    .toList();
                            Timestamp? timestamp =
                                data['timestamp'] as Timestamp?;
                            final location = data['location'] ?? '';
                            final type = data['type'] ?? '';
                            final title = data['title'] ?? '';
                            final tag = data['tag'] ?? '';
                            print(text);
                            print(images);
                            print(location);
                            return PostItem(
                              Refuid: user.data!.uid.toString() ?? '',
                              images: List<String>.from(images!),
                              text: text.toString(),
                              like: false,
                              pid: pid,
                              uid: refUsers.toString(),
                              tag: tag,
                              RefEvent: RefEvent,
                              location: location.toString(),
                              title: title.toString(),
                              type: type,
                            );
                          },
                        )
                      ]);
                    }
                    return Container();
                  },
                );
              })),
    );
  }
}
