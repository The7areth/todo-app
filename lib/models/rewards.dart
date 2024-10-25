class Reward {
  final int id;
  final String username; // Add username field
  final String title;
  final String description;
  final int points;

  Reward({
    required this.id,
    required this.username, // Add username field
    required this.title,
    required this.description,
    required this.points,
  });

  // Convert a Reward into a Map (for storing in a database)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username, // Add username to the map
      'title': title,
      'description': description,
      'points': points,
    };
  }

  // Create a Reward object from a Map (for retrieving from a database)
  factory Reward.fromMap(Map<String, dynamic> map) {
    return Reward(
      id: map['id'],
      username: map['username'], // Add username field
      title: map['title'],
      description: map['description'],
      points: map['points'],
    );
  }
}
