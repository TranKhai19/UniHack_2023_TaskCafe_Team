class Deliverable {
  int participantNumber;
  List<String> equipment;
  String datetimeStart;
  String datetimeEnd;

  Deliverable({
    required this.participantNumber,
    required this.equipment,
    required this.datetimeStart,
    required this.datetimeEnd,
  });

  toJson() {}

  static fromJson(documentSnapshot) {}
}
