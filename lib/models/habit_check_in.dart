class HabitCheckIn {
  final int id;
  final int habitId;
  final DateTime date;  // Check-in date
  final bool checkedIn; // Whether the habit was checked in on this date

  HabitCheckIn({
    required this.id,
    required this.habitId,
    required this.date,
    required this.checkedIn,
  });

  // Convert a HabitCheckIn object to a Map (for storing in the database)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'habitId': habitId,
      'date': date.toIso8601String(),
      'checkedIn': checkedIn ? 1 : 0,  // Use 1/0 for boolean values in SQLite
    };
  }

  // Create a HabitCheckIn object from a Map (for retrieving from the database)
  factory HabitCheckIn.fromMap(Map<String, dynamic> map) {
    return HabitCheckIn(
      id: map['id'],
      habitId: map['habitId'],
      date: DateTime.parse(map['date']),
      checkedIn: map['checkedIn'] == 1,
    );
  }
}
