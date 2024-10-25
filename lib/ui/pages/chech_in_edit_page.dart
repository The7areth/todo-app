import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../controllers/check_in_controller.dart';
import '../../models/habit_check_in.dart';

class HabitCheckInEditPage extends StatefulWidget {
  final DateTime date;
  final int habitId;
  final VoidCallback onSave; // Callback to trigger when a check-in is saved

  HabitCheckInEditPage({
    required this.date,
    required this.habitId,
    required this.onSave,
  });

  @override
  _HabitCheckInEditPageState createState() => _HabitCheckInEditPageState();
}

class _HabitCheckInEditPageState extends State<HabitCheckInEditPage> {
  bool _isCheckedIn = false; // Initial value for the check-in switch
  final HabitCheckInController _checkInController = HabitCheckInController(); // Initialize the controller

  @override
  void initState() {
    super.initState();
    _loadCheckInStatus(); // Load the check-in status when the page is opened
  }

  // Load the check-in status for this habit and date
  Future<void> _loadCheckInStatus() async {
    HabitCheckIn? checkIn = await _checkInController.getCheckIn(widget.habitId, widget.date);
    if (checkIn != null) {
      setState(() {
        _isCheckedIn = checkIn.checkedIn; // Set the switch based on existing check-in
      });
    }
  }

  // Save the check-in status to the database
  Future<void> _saveCheckInStatus() async {
    // Create or update the check-in record for this date
    HabitCheckIn checkIn = HabitCheckIn(
      id: 0, // New check-in (ID will be auto-generated if necessary)
      habitId: widget.habitId,
      date: widget.date,
      checkedIn: _isCheckedIn, // Current value of the switch
    );

    await _checkInController.saveCheckIn(checkIn); // Save check-in to the database
    widget.onSave(); // Trigger the onSave callback to refresh the calendar
    Navigator.pop(context); // Close the page after saving
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Check-in for ${DateFormat('dd MMM EEE').format(widget.date)}'),
    ),
    body: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
    // Show date
    Text(
    'Habit Check-in for ${DateFormat('dd MMM EEE').format(widget.date)}',
    style: TextStyle(fontSize: 18),
    ),
    SizedBox(height: 20),


      // A switch to mark check-in (Yes/No)
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Check-in status:'),
          Switch(
            value: _isCheckedIn,  // Bind the switch to _isCheckedIn
            onChanged: (value) {
              setState(() {
                _isCheckedIn = value; // Toggle the check-in status
              });
            },
          ),
        ],
      ),

      // Save button
      SizedBox(height: 20),
      ElevatedButton(
        onPressed: _saveCheckInStatus,  // Call saveCheckInStatus when the button is pressed
        child: Text('Save Check-in'),
      ),
    ],
    ),
    ),
    );
  }
}
