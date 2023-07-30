import 'package:cloud_firestore/cloud_firestore.dart';

final CollectionReference usersCollection = FirebaseFirestore.instance.collection('Users');
final CollectionReference postsCollection = FirebaseFirestore.instance.collection('Posts');
final CollectionReference eventsCollection = FirebaseFirestore.instance.collection('Events');
final CollectionReference commentsCollection = FirebaseFirestore.instance.collection('Comments');

// CREATE

Future<String> createUser(String name, String email, String avatar) async {
  DocumentReference newUserRef = await usersCollection.add({
    'name': name,
    'email': email,
    'avatar': avatar,
  });
  return newUserRef.id;
}

Future<String> createPost(String userId, String content) async {
  DocumentReference newPostRef = await postsCollection.add({
    'userId': userId,
    'content': content,
    'timestamp': DateTime.now(),
    'likes': 0,
    'comments': [],
  });
  return newPostRef.id;
}

Future<String> createEvent(String userId, String postId) async {
  DocumentReference newEventRef = await eventsCollection.add({
    'userId': userId,
    'postId': postId,
    'timestamp': DateTime.now(),
    'attendees': 0,
  });
  return newEventRef.id;
}

Future<String> createComment(String userId, String postId, String content) async {
  DocumentReference newCommentRef = await commentsCollection.add({
    'userId': userId,
    'postId': postId,
    'content': content,
    'timestamp': DateTime.now(),
  });
  return newCommentRef.id;
}

// READ

Stream<List<DocumentSnapshot>> getUsers() {
  return usersCollection.snapshots().map((QuerySnapshot querySnapshot) => querySnapshot.docs);
}

Stream<List<DocumentSnapshot>> getPosts() {
  return postsCollection.snapshots().map((QuerySnapshot querySnapshot) => querySnapshot.docs);
}

Stream<List<DocumentSnapshot>> getEvents() {
  return eventsCollection.snapshots().map((QuerySnapshot querySnapshot) => querySnapshot.docs);
}

Stream<List<DocumentSnapshot>> getComments(String postId) {
  return commentsCollection
      .where('postId', isEqualTo: postId)
      .orderBy('timestamp', descending: true)
      .snapshots()
      .map((QuerySnapshot querySnapshot) => querySnapshot.docs);
}

// UPDATE

Future<void> updatePostLikes(String postId, int newLikesCount) async {
  DocumentReference postRef = postsCollection.doc(postId);
  await postRef.update({'likes': newLikesCount});
}

Future<void> updateEventAttendees(String eventId, int newAttendeesCount) async {
  DocumentReference eventRef = eventsCollection.doc(eventId);
  await eventRef.update({'attendees': newAttendeesCount});
}

// DELETE

Future<void> deleteUser(String userId) async {
  DocumentReference userRef = usersCollection.doc(userId);
  await userRef.delete();
}

Future<void> deletePost(String postId) async {
  DocumentReference postRef = postsCollection.doc(postId);
  await postRef.delete();
}

Future<void> deleteEvent(String eventId) async {
  DocumentReference eventRef = eventsCollection.doc(eventId);
  await eventRef.delete();
}

Future<void> deleteComment(String commentId) async {
  DocumentReference commentRef = commentsCollection.doc(commentId);
  await commentRef.delete();
}
