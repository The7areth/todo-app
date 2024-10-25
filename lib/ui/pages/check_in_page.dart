import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../controllers/check_in_controller.dart';
import '../../models/habit_check_in.dart';
import 'chech_in_edit_page.dart';

class HabitCheckInPage extends StatefulWidget {
  final int habitId;

  HabitCheckInPage({required this.habitId});

  @override
  _HabitCheckInPageState createState() => _HabitCheckInPageState();
}

class _HabitCheckInPageState extends State<HabitCheckInPage> {
  List<DateTime> _checkedInDates = []; // List to store checked-in dates
  int _monthlyCheckIns = 0;  // To store the number of monthly check-ins
  int _totalCheckIns = 0;    // To store the total check-ins
  int _bestStreak = 0;       // To store the best streak
  final HabitCheckInController _checkInController = HabitCheckInController(); // Controller instance

  @override
  void initState() {
    super.initState();
    _loadCheckInsForMonth(); // Load check-ins for the current month
    _loadCheckInStatistics(); // Load the statistics (best streak, total check-ins)
  }

  // Load check-ins for the current habit and month
  Future<void> _loadCheckInsForMonth() async {
    List<HabitCheckIn> checkIns = await _checkInController.getCheckInsForMonth(widget.habitId, DateTime.now().year, DateTime.now().month);
    setState(() {
      _checkedInDates = checkIns.map((checkIn) => checkIn.date).toList(); // Extract dates from check-ins
      _monthlyCheckIns = _checkedInDates.length; // Calculate monthly check-ins
    });
  }

  // Load the total check-ins and best streak statistics
  Future<void> _loadCheckInStatistics() async {
    // Get the total check-ins for the habit
    List<HabitCheckIn> allCheckIns = await _checkInController.getAllCheckIns(widget.habitId);
    setState(() {
      _totalCheckIns = allCheckIns.length; // Set total check-ins
      _bestStreak = _calculateBestStreak(allCheckIns); // Calculate the best streak
    });
  }

  // Calculate the best streak from all check-ins
  int _calculateBestStreak(List<HabitCheckIn> checkIns) {
    int bestStreak = 0;
    int currentStreak = 0;
    DateTime? previousDate;

    for (var checkIn in checkIns) {
      if (previousDate != null && checkIn.date.difference(previousDate).inDays == 1) {
        currentStreak++;
      } else {
        currentStreak = 1;
      }
      bestStreak = currentStreak > bestStreak ? currentStreak : bestStreak;
      previousDate = checkIn.date;
    }

    return bestStreak;
  }


  // Build the calendar
  Widget _buildCalendar(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text('October', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          // Create a 7-column grid (7 days in a week)
          GridView.count(
            crossAxisCount: 7, // 7 days in a week
            shrinkWrap: true,
            children: List.generate(31, (index) {
              DateTime date = DateTime(2023, 10, index + 1); // Example date in October
              return InkWell(
                onTap: () {
                  // Navigate to a check-in edit page for the selected date
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HabitCheckInEditPage(
                        date: date,
                        habitId: widget.habitId,
                        onSave: () => _loadCheckInsForMonth(), // Reload check-ins after saving
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: _getCheckInColor(date), // Color based on check-in status
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}', // Show the day number
                      style: TextStyle(color: Colors.black), // Text color remains black
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  // Determine the color for each day (orange if checked-in, white if not)
  Color _getCheckInColor(DateTime date) {
    if (_checkedInDates.contains(date)) {
      return Colors.orangeAccent; // Orange for checked-in days
    }
    return Colors.white; // White for days not checked-in
  }

  // Build the check-in statistics section
  Widget _buildCheckInStatistics() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Check-in Statistics', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildStatisticCard('Monthly check-ins', '$_monthlyCheckIns Days'),
            _buildStatisticCard('Total check-ins', '$_totalCheckIns Days'),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildStatisticCard('Best Streak', '$_bestStreak Days'),
          ],
        ),
      ],
    );
  }

  // Build a statistic card
  Widget _buildStatisticCard(String title, String value) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            SizedBox(height: 5),
            Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Check-in'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Calendar Section
            _buildCalendar(context),
            // Check-in Statistics Section
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildCheckInStatistics(),
            ),
            // Other sections can go here...
          ],
        ),
      ),
    );
  }
}
