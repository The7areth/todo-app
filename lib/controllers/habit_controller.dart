import 'package:get/get.dart';
import 'package:untitled/models/habit.dart';
import '../db/habit_db_helper.dart';

class HabitController extends GetxController {
  final RxList<Habit> habitList = <Habit>[].obs;

  Future<int> addHabit({Habit? habit}) {
    return HabitDbHelper.insertHabit(habit);
  }

  Future<void> getHabit() async {
    final List<Map<String, dynamic>> habits = await HabitDbHelper.query();

    habitList.assignAll(habits.map((data) => Habit.fromJson(data)).toList());
  }

  void deleteHabit(Habit habit) async {
    await HabitDbHelper.deleteHabit(habit);
    getHabit();
  }void deleteAllHabit() async {
    await HabitDbHelper.deleteAllHabit();
    getHabit();
  }

  void markHabitCompleted(int id) async {
    await HabitDbHelper.updateHabit(id);
    getHabit();
  }
}