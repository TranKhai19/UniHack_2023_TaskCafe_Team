
import 'Deliverable.dart';
import 'Plan.dart';
import 'Report.dart';


class Event {
  String title;
  String description;
  String location;
  Deliverable deliverable;
  List<Plan> pre;
  List<Plan> during;
  Report report; // Renamed "Post" to "Report"

  Event({
    required this.title,
    required this.description,
    required this.location,
    required this.deliverable,
    required this.pre,
    required this.during,
    required this.report, // Renamed "Post" to "Report"
  });

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "location": location,
      "deliverable": deliverable.toJson(),
      "pre": pre.map((plan) => plan.toJson()).toList(),
      "during": during.map((plan) => plan.toJson()).toList(),
      "post": report.toJson(),
    };
  }
}


