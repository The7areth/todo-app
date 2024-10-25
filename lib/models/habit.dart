import 'dart:convert';

class Habit {
  int? id;
  String? name;
  String? description;
  DateTime? startDate;
  // String? frequency; // For example: Daily, Weekly, etc.
  DateTime? remind;
  bool? isCompleted;

  Habit({
    this.id,
    required this.name,
    required this.description,
    required this.startDate,
    // required this.frequency,
    this.isCompleted = false,
    this.remind
  });

  // Convert a Habit into a Map to save it to the database
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'startDate': startDate?.toIso8601String(),
      'remind': remind,
      'isCompleted': isCompleted! ? 1 : 0,
    };
  }

  // Convert a Map to a Habit object
  factory Habit.fromJson(Map<String, dynamic> map) {
    print(map);

    return Habit(
      id: map['id'],
      name: map['name'].toString(),
      description: map['description'].toString(),
      startDate: DateTime.parse(map['startDate']),
      // frequency: map['frequency'],
      isCompleted: map['isCompleted'] == 1,
    );
  }
}

