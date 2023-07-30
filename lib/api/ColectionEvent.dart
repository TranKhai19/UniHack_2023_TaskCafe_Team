// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/models/Deliverable.dart';
import '../data/models/Event.dart';
import '../data/models/Plan.dart';
import '../data/models/Report.dart';

Future<void> addEventDataToFirestore(Event event) async {
  try {
    // Convert the Event model to JSON
    Map<String, dynamic> eventData = event.toJson();

    // Replace "eventCollection" with the name of the collection where you want to store the data.
    await FirebaseFirestore.instance
        .collection('eventCollection')
        .add(eventData);
    print("Event data added to Firestore successfully!");
  } catch (e) {
    print("Error adding event data to Firestore: $e");
  }
}

// Function to get an event by its ID from Firestore
Future<Event?> getEventByIdFromFirestore(String eventId) async {
  try {
    // Replace "eventCollection" with the name of the collection where the event is stored.
    final documentSnapshot = await FirebaseFirestore.instance
        .collection('eventCollection')
        .doc(eventId)
        .get();

    if (documentSnapshot.exists) {
      return Event(
        title: documentSnapshot["title"],
        description: documentSnapshot["description"],
        location: documentSnapshot["location"],
        deliverable: Deliverable.fromJson(documentSnapshot["deliverable"]),
        pre: (documentSnapshot["pre"] as List)
            .map((item) => Plan.fromJson(item))
            .toList(),
        during: (documentSnapshot["during"] as List)
            .map((item) => Plan.fromJson(item))
            .toList(),
        report: Report.fromJson(documentSnapshot["post"]),
      );
    } else {
      print("Document with ID $eventId does not exist in Firestore.");
      return null;
    }
  } catch (e) {
    print("Error getting event from Firestore: $e");
    return null;
  }
}
// https://stackoverflow.com/questions/62214831/update-the-map-field-flutter
