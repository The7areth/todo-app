class Project {
  final int id;
  final String name;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final String status;

  Project({
    required this.id,
    required this.name,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.status,
  });

  // Convert a Project object to a Map (for storing in a database)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'status': status,
    };
  }

  // Create a Project object from a Map (for retrieving from a database)
  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      status: json['status'],
    );
  }
}
