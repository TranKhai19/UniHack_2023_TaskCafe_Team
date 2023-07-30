import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:unihack/bloc/authentication/authentication_bloc.dart';
import 'package:unihack/screens/home/_widget/headerPost.dart';
import 'package:unihack/screens/home_view_screen.dart';
import 'package:unihack/widgets/Loading/Loading.dart';
import 'package:unihack/widgets/PostItem/PostItem.dart';

import '../../../bloc/indextBloc.dart';
import '../../../data/repositories/person_repository.dart';
import '../../authentication/login_screen.dart';

class Posts extends StatefulWidget {
  final String? currentUser;
  const Posts({Key? key, required this.currentUser}) : super(key: key);

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Post').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loading();
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        final List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
       
        return Container(
          child: ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
                final currentPost = documents[index];
    final content = currentPost['content'] ?? '';
    final location = currentPost['location'] ?? '';
    final type = currentPost['type'] ?? '';
    final RefEvent = currentPost['RefEvent'] ?? '';
    final title = currentPost['title'] ?? '';
    final images = currentPost['Images'] ?? [];
    final uid = currentPost['userId'] ?? '';
    final tag = currentPost['tag'] ?? '';
    final refUsers = currentPost['RefUsers'] ?? [];
    final pid = documents[index].id;

              print(pid);
              if (widget.currentUser != null) {
                if (index == 0) {
                  return Column(
                    children: <Widget>[
                      Container(
                        height: 30,
                        decoration: BoxDecoration(
                          color: Color(0xFFF8F8EC),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25)
                          )
                        ),
                      ),
                      PostItem(
                        Refuid: widget.currentUser ?? '',
                        like: refUsers.contains(widget.currentUser ?? '') ? true : false,
                        text: content,
                        images: List<String>.from(images),
                        uid: uid,
                        pid: pid,
                        title: title,
                        location: location,
                        type: type,
                        RefEvent: RefEvent,
                         tag: tag,
                      ),
                    ],
                  );
                } else {
                  return ListTile(
                    title: Text('Item $index'),
                  );
                }
              }
            },
          ),
        );
      },
    );
  }
}
