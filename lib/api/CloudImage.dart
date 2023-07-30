import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:uuid/uuid.dart';

Future<String> generateUuid() async {
  var uuid = Uuid();
  return uuid.v4();
}

Future<String?> uploadImageToFirebase(String filePath) async {
  File image = File(filePath);

  if (image.existsSync()) {
    String fileName = await generateUuid();
    firebase_storage.Reference reference = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('image/$fileName.jpg');

    try {
      firebase_storage.UploadTask uploadTask = reference.putFile(image);
      firebase_storage.TaskSnapshot taskSnapshot = await uploadTask;
      String downloadURL = await taskSnapshot.ref.getDownloadURL();
      return downloadURL; // Return the download URL
    } catch (e) {
      print("Error uploading image: $e");
      return null; // Return null in case of an error
    }
  } else {
    print("File does not exist!");
    return null; // Return null if the file doesn't exist
  }
}

