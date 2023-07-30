class Report {
  String cleanupStatus;
  bool reportSubmitted;

  Report({
    required this.cleanupStatus,
    required this.reportSubmitted,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      cleanupStatus: json['cleanupStatus'],
      reportSubmitted: json['reportSubmitted'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cleanupStatus': cleanupStatus,
      'reportSubmitted': reportSubmitted,
    };
  }
}
