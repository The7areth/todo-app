import 'dart:convert';

class Task {
  int? id;
  String? title;
  String? note;
  int? isCompleted;
  String? date;
  String? startTime;
  String? endTime;
<<<<<<< HEAD
  String? projectName;
=======
>>>>>>> 3228cf64149e5868d9b162b36e51efef35ac2200
  int? color;
  int? remind;
  String? repeat;
  String? value;  // Added value field
  String? unit;   // Added unit field
  Task({
    this.id,
    this.title,
    this.note,
<<<<<<< HEAD
    this.projectName,
=======
>>>>>>> 3228cf64149e5868d9b162b36e51efef35ac2200
    this.isCompleted,
    this.date,
    this.startTime,
    this.endTime,
    this.color,
    this.remind,
    this.repeat,
    this.value,
    this.unit

  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'note': note,
      'isCompleted': isCompleted,
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
      'color': id,
      'remind': remind,
      'repeat': repeat,
    };
  }

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    note = json['note'];
    isCompleted = json['isCompleted'];
    date = json['date'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    color = json['color'];
    remind = json['remind'];
    repeat = json['repeat'];
  }
}
