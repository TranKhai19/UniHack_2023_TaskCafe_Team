class Landfill {
  Size size;
  List<String> dumpLocationType;
  List<String> typeOfGarbage;
  int pollutionDegree;

  Landfill({
    required this.size,
    required this.dumpLocationType,
    required this.typeOfGarbage,
    required this.pollutionDegree,
  });

  factory Landfill.fromJson(Map<String, dynamic> json) {
    return Landfill(
      size: Size.fromJson(json['size']),
      dumpLocationType: List<String>.from(json['dumpLocationType']),
      typeOfGarbage: List<String>.from(json['typeOfGarbage']),
      pollutionDegree: json['pollutionDegree'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'size': size.toJson(),
      'dumpLocationType': dumpLocationType,
      'typeOfGarbage': typeOfGarbage,
      'pollutionDegree': pollutionDegree,
    };
  }
}
class Size {
  int area;
  int mass;

  Size({
    required this.area,
    required this.mass,
  });

  factory Size.fromJson(Map<String, dynamic> json) {
    return Size(
      area: json['area'],
      mass: json['mass'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'area': area,
      'mass': mass,
    };
  }
}
