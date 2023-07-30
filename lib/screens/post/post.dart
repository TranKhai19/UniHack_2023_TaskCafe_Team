import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unihack/widgets/PostItem/PostItem.dart';
import 'package:unihack/widgets/Loading/Loading.dart';

import '../../bloc/authentication/authentication_bloc.dart';
import '../../bloc/indextBloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

@RoutePage()
class Post extends StatefulWidget {
  final String id;

  const Post({Key? key, required this.id}) : super(key: key);

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  final TextEditingController _commentController = TextEditingController();
  final FocusNode _FocusNode = FocusNode();
  String? currentUser;

  @override
  void dispose() {
    _commentController.dispose();
    _FocusNode.dispose();
    super.dispose();
  }

  void _sendComment() async {
    String newComment = _commentController.text;
    String postId = widget.id;
    String uid = '2SBiZkvQeyQZDKch6UCgpV7OETX2';
    if (currentUser == null) {
      EasyLoading.showError('Vui lòng đăng Nhập');
      return;
    }
    DocumentReference commentRef =
        await FirebaseFirestore.instance.collection('Comment').add({
      'RefUser': uid,
      'content': newComment,
      'timestamp': Timestamp.now(),
      // Add more data as needed, e.g., the user who posted the comment
    });

    String commentId = commentRef.id;

    FirebaseFirestore.instance.collection('Post').doc(postId).update({
      'RefComment': FieldValue.arrayUnion([commentId]),
    });

    _commentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);
    final indexBlocData = IndextBlocProvider.of(context);
    final AuthenticationBloc authenticationBloc =
        indexBlocData.indextBloc.authenticationBloc;
    String idPost = widget.id;
    final user =
        '2SBiZkvQeyQZDKch6UCgpV7OETX2'; // User ID, change this according to your needs

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        title: Text('Bình Luận',style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,color: Colors.black),
          onPressed: () {
            router.pop();
          },
        ),
      ),
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        bloc: authenticationBloc,
        listener: (context, state) {
          print('State home ${state.toString()}');
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
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Post')
              .doc(idPost)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Loading();
            }
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (!snapshot.hasData || snapshot.data == null) {
              return Text('No data available');
            }

            var data = snapshot.data!.data() as Map<String, dynamic>;
            String? text = data['content'] as String?;
            List<String>? images = (data['Images'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList();
            String? userId = data['userId'] as String?;
            bool like = (data['likes'] as int?) == 1;
            String pid = snapshot.data!.id;

            List<String>? refComments = (data['RefComment'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList();
            refComments?.reversed.toList();
            List<String>? refUsers = (data['RefUsers'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList();
            Timestamp? timestamp = data['timestamp'] as Timestamp?;
            final location = data['location'] ?? '';
            final type = data['type'] ?? '';
            final title = data['title'] ?? '';

            return SingleChildScrollView(
              // Wrap the entire body with SingleChildScrollView
              child: Column(
                children: [
                  PostItem(
                    text: text ?? '',
                    images: images ?? [],
                    Refuid: currentUser ?? '',
                    like: refUsers!.contains(currentUser ?? '') ? true : false,
                    pid: pid,
                    uid: '$userId',
                    title: title,
                    location: location,
                    type: type,
                    callbackComment: () {
                      // Handle callbackComment event
                      _FocusNode.requestFocus();
                      print('change eee');
                    },
                    callbackEvent: () {
                      // Handle callbackEvent event
                      print('change vvv');
                    }, tag: '',
                  ),
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: refComments?.length ?? 0,
                    itemBuilder: (context, index) {
                      final commentId = refComments![index];
                      return StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('Comment')
                            .doc(commentId.toString().trim())
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Container(
                              child: Text('Error: ${snapshot.error}'),
                            );
                          } else if (snapshot.hasData) {
                            var commentData = snapshot.data!.data();
                            if (commentData is Map) {
                              var refUser = commentData['RefUser'];
                              var content = commentData['content'];
                              dynamic date = commentData['date'];
                              return StreamBuilder<DocumentSnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('Users')
                                    .doc(refUser.toString().trim())
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
                                        padding: EdgeInsets.all(10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  width: 1,
                                                  color: const Color.fromARGB(
                                                      255, 212, 212, 212),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(60),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(60),
                                                child: Image.network(
                                                  avatar,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  fullName,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      80,
                                                  child: Text(
                                                    content,
                                                    style: TextStyle(),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 20,
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    }
                                  }

                                  return Container();
                                },
                              );
                            }

                            return Container();
                          }

                          return Container();
                        },
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 10,
          right: 10,
          top: 10,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextField(
            controller: _commentController,
            focusNode: _FocusNode,
            onTap: () => _FocusNode
                .requestFocus(), // Assign the _focusNode to the TextField
            decoration: InputDecoration(
              hintText: 'Nhập bình luận của bạn...',
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              suffixIcon: IconButton(
                icon: Icon(Icons.send, color: const Color(0xFF50C1AC)),
                onPressed: _sendComment,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
