class Plan {
  String title;
  int priority;
  String description;
  String status;

  Plan({
    required this.title,
    required this.priority,
    required this.description,
    required this.status,
  });

  factory Plan.fromJson(Map<String, dynamic> json) {
    return Plan(
      title: json['title'],
      priority: json['priority'],
      description: json['description'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'priority': priority,
      'description': description,
      'status': status,
    };
  }
}
