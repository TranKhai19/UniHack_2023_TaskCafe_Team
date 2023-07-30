
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:unihack/router/auto_router.gr.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class PostItem extends StatefulWidget {
  final String text;
  final List<String> images;
  final String Refuid; // user id tồn tại bên trong mảng  (ID người dùng )
  final String uid; // user id của người tạo bài
  final String pid; // id cua bai post
  final String? RefEvent;
  final bool like;
  final String tag;
  final String? title;
  final String? location;
  final bool? type; // kiểm tra kiểu của bài viết "Event" hoặc "default"
  final VoidCallback? callbackComment;
  final VoidCallback? callbackEvent;
  
  

  const PostItem({
    Key? key,
    required this.text,
    required this.images,
    required this.Refuid,
    required this.like,
    required this.pid,
    required this.uid,
    this.RefEvent,
    this.title,
     required this.tag,
    this.location,
    this.type,
    this.callbackComment,
    this.callbackEvent,
  }) : super(key: key);

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  int _currentIndex = 0;
  bool isDataLoaded = false;
  final CarouselController _controller = CarouselController();
  void addItemToRefUsers(String documentId, String itemId) {
    try {
      if (itemId == "" || itemId.length == 0) {
        EasyLoading.showError('Vui lòng đăng Nhập');
        return;
      }
      CollectionReference collectionRef =
          FirebaseFirestore.instance.collection('Post');
      DocumentReference documentRef = collectionRef.doc(documentId);
      documentRef.update({
        'RefUsers': FieldValue.arrayUnion([itemId])
      }).then((_) {
        print('Item added successfully to RefUsers array.');
      }).catchError((error) {
        print('Failed to add item to RefUsers array: $error');
      });
    } catch (e) {
      print(e);
    }
  }

  void removeItemFromRefUsers(String documentId, String itemId) {
    try {
     if (itemId == "" || itemId.length == 0) {
        EasyLoading.showError('Vui lòng đăng Nhập');
        return;
      }
      CollectionReference collectionRef =
          FirebaseFirestore.instance.collection('Post');
      DocumentReference documentRef = collectionRef.doc(documentId);

      documentRef.update({
        'RefUsers': FieldValue.arrayRemove([itemId])
      }).then((_) {
        print('Item removed successfully from RefUsers array.');
      }).catchError((error) {
        print('Failed to remove item from RefUsers array: $error');
      });
    } catch (e) {
      print(e);
    }
  }

  void defaultComment() {
    context.pushRoute(Post(id: widget.pid));
  }

  void defaultEvent() {
    // code here
    if(widget.RefEvent != null){
      context.pushRoute(Event(id: widget.RefEvent.toString().trim()!));
    }
  }
  @override
  Widget build(BuildContext context) {
    print(widget.RefEvent);
    print(widget.Refuid);
    print(widget.images);
    print(widget.pid);
    print(widget.tag);
    final imageSliders = widget.images
        .map((item) => Container(
              margin: const EdgeInsets.all(5.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Image.network(
                  item,
                  fit: BoxFit.cover,
                  width: 1000.0,
                  height: 350.0,
                ),
              ),
            ))
        .toList();

    final length = widget.images.length;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border(bottom: BorderSide.none),
        color: Color(0xFFF8F8EC),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //------------------- Header
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('Users')
                      .doc(widget.uid.trim())
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Container(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else if (snapshot.hasData) {
                      var userData = snapshot.data!.data();
                      print('avatar--------------------');
                      print(widget.uid);
                      if (userData is Map<String, dynamic>) {
                        var avatarUrl = userData['avatar'] as String;
                        var fullName = userData['fullName'] as String;

                        return Row(
                          children: <Widget>[
                            Container(
                              height: 30.0,
                              width: 30.0,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1.0,
                                  color: Color.fromARGB(255, 212, 212, 212),
                                ),
                                borderRadius: BorderRadius.circular(60.0),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(60.0),
                                child: Image.network(
                                  avatarUrl,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            SizedBox(width: 10.0),
                            Text(
                              fullName,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        );
                      }
                    }

                    return Container();
                  },
                ),
                // if (widget.type == true)
                //   Container(
                //     padding:
                //         EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                //     decoration: const BoxDecoration(
                //       borderRadius: BorderRadius.all(Radius.circular(25)),
                //       color: Color(0xFF50C1AC),
                //     ),
                //     alignment: Alignment.center,
                //     child: Text(
                //       'event',
                //       style: TextStyle(
                //         color: Colors.white,
                //       ),
                //     ),
                //   )
                 Container(
                    padding:
                        EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      color: Color(0xFF50C1AC),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      widget.tag.toString(),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )
              ],
            ),
          ),
          if (widget.title != null && widget.type == true)
            Container(
              padding: const EdgeInsets.only(bottom: 5, left: 10, right: 10),
              child: Text(
                widget.title ?? "",
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20.0,
                  fontFamily: 'Roboto',
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              widget.text,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16.0,
                fontFamily: 'Roboto',
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (widget.location != null && widget.type == true)
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Icon(Icons.location_on, color: Color(0xFF50C1AC)),
                ),
                Container(
                  padding:
                      const EdgeInsets.only(bottom: 5, left: 10, right: 10),
                  child: Text(
                    widget.location ?? "",
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.0,
                      fontFamily: 'Roboto',
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          //------------------- Slider
          Stack(
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
                items: imageSliders,
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
                        '${_currentIndex + 1}/$length',
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
          //------------------- ToolBottom
          Container(
            padding: EdgeInsets.all(0.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color.fromARGB(255, 231, 231, 231),
                  width: 4.0,
                ),
              ),
            ),
            child:Container(
              padding: EdgeInsets.all(2),
              margin: EdgeInsets.all(2),
              decoration:BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.white
              ) ,
              child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    TextButton(
                      onPressed: widget.like
                          ? () {
                              //code is here
                              removeItemFromRefUsers(widget.pid, widget.Refuid);
                            }
                          : () {
                              //code is here
                              addItemToRefUsers(widget.pid, widget.Refuid);
                            },
                      child: Icon(
                        widget.like
                            ? Icons.favorite
                            : Icons.favorite_border_outlined,
                        color: widget.like ? Colors.red : Colors.grey,
                      ),
                    ),
                    TextButton(
                        onPressed: widget.callbackComment ?? defaultComment,
                        child: Column(
                          children: [
                            Icon(
                              Icons.comment_bank_outlined,
                              color: Colors.grey,
                            ),
                          ],
                        )),
                    if (widget.type == true)
                      TextButton(
                        onPressed: widget.callbackEvent ?? defaultEvent,
                        child: Icon(
                          Icons.receipt_long,
                          color: Colors.grey,
                        ),
                      ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    if (widget.type == true)
                      TextButton(
                        onPressed: () {
                          //code is here
                        },
                        child: Icon(
                          Icons.format_list_bulleted_add,
                          color: Colors.grey,
                        ),
                      ),
                  ],
                ),
              ],
            ),
            )
          ),
        ],
      ),
    );
  }
}
