import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:untitled/controllers/task_controller.dart';
import 'package:untitled/models/task.dart';
import 'package:untitled/ui/theme.dart';
import 'package:untitled/ui/widgets/button.dart';
import 'package:untitled/ui/widgets/input_field.dart';

class AddHabitPage extends StatefulWidget {
  @override
  State<AddHabitPage> createState() => _AddHabitPageState();
}

class _AddHabitPageState extends State<AddHabitPage> {
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _habitnController = TextEditingController();
  final TextEditingController _DescriptionController = TextEditingController();
  final TextEditingController _habitValueController = TextEditingController();
  final TextEditingController _customUnitController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
<<<<<<< HEAD
  String _startTime = DateFormat("hh:mm").format(DateTime.now());
  String _endTime = DateFormat("hh:mm").format(DateTime.now().add(const Duration(minutes: 15)));
=======
  String _startTime = DateFormat("hh:mm a").format(DateTime.now());
  String _endTime = DateFormat("hh:mm a").format(DateTime.now().add(const Duration(minutes: 15)));
>>>>>>> 3228cf64149e5868d9b162b36e51efef35ac2200
  int _selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 20];
  String _selectedUnit = 'Cups';
  bool _isCustomUnit = false;
  List<String> unitList = ['Cups', 'cm', 'Minutes', 'Hours', 'Custom'];
  int _selectedColor = 0;

  // For day selection
  List<bool> _selectedDays = [false, false, false, false, false, false, false]; // For M, T, W, T, F, S, S

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.colorScheme.background,
      appBar: _appBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("Add Habit", style: headingStyle),
              InputField(
                title: "Habit Name",
                hint: "Enter name here",
                controller: _habitnController,
              ),
              InputField(
                title: "Description",
                hint: "Enter description here",
                controller: _DescriptionController,
              ),
              // Custom Value and Unit Input
              _habitUnitInput(),
              const SizedBox(height: 15),
              // Day selector for habit repetition
              _daySelector(),
              Row(
                children: [
                  Expanded(
                    child: InputField(
                      title: "Reminder Time",
                      hint: _startTime,
                      widget: IconButton(
                        onPressed: () => _getTimeFromUser(isStartTime: true),
                        icon: const Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MyButton(
                    label: "Add Habit",
                    onTap: () {
                      _validateDate();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // AppBar definition
  AppBar _appBar() {
    return AppBar(
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: const Icon(
          Icons.arrow_back,
          size: 24,
          color: primaryClr,
        ),
      ),
      elevation: 0,
      backgroundColor: context.theme.colorScheme.background,
      actions: const [
        CircleAvatar(
          backgroundImage: AssetImage("images/person.jpeg"),
          radius: 18,
        ),
        SizedBox(width: 20),
      ],
    );
  }

  // Custom Value and Unit Input
  Widget _habitUnitInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputField(
          title: "Date",
          hint: DateFormat.yMd().format(_selectedDate),
          widget: IconButton(
            onPressed: () => _getDateFromUser(),
            icon: const Icon(
              Icons.calendar_today_outlined,
              color: Colors.grey,
            ),
          ),
        ),
        Text("Goal:", style: titleStyle), // Move the label above
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _habitValueController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Value',
                  hintText: 'Enter a number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _isCustomUnit
                  ? TextField(
                controller: _customUnitController,
                decoration: InputDecoration(
                  labelText: 'Custom Unit',
                  hintText: 'Enter custom unit',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              )
                  : DropdownButtonFormField<String>(
                value: _selectedUnit,
                items: unitList.map((unit) {
                  return DropdownMenuItem(
                    value: unit,
                    child: Text(unit),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value == 'Custom') {
                    setState(() {
                      _isCustomUnit = true;
                    });
                  } else {
                    setState(() {
                      _isCustomUnit = false;
                      _selectedUnit = value!;
                    });
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Unit',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Day Selector for Habit Repetition
  Widget _daySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text("Repeat on:", style: titleStyle),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: ['M', 'T', 'W', 'T', 'F', 'S', 'S'].asMap().entries.map((entry) {
            int idx = entry.key;
            String day = entry.value;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedDays[idx] = !_selectedDays[idx];
                });
              },
              child: CircleAvatar(
                radius: 18,
                backgroundColor: _selectedDays[idx] ? primaryClr : Colors.grey.shade200,
                child: Text(
                  day,
                  style: TextStyle(
                    color: _selectedDays[idx] ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  _validateDate() {
    if (_habitnController.text.isNotEmpty && _DescriptionController.text.isNotEmpty) {
      _addTasksToDb();
      Get.back();
    } else {
      Get.snackbar(
        "Required",
        "All fields are required!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        colorText: pinkClr,
        icon: const Icon(
          Icons.warning_amber_rounded,
          color: Colors.red,
        ),
      );
    }
  }

  _addTasksToDb() async {
    String selectedDays = _selectedDays.asMap().entries
        .where((entry) => entry.value)
        .map((entry) => ['M', 'T', 'W', 'T', 'F', 'S', 'S'][entry.key])
        .join(',');

    String finalUnit = _isCustomUnit ? _customUnitController.text : _selectedUnit;

    // Create a Task instance
    Task newTask = Task(
      title: _habitnController.text,
      note: _DescriptionController.text,
      isCompleted: 0,
      date: DateFormat.yMd().format(_selectedDate),
      startTime: _startTime,
      endTime: _endTime,
      color: _selectedColor,
      remind: _selectedRemind,
      repeat: selectedDays,
      value: _habitValueController.text,  // Habit value
      unit: finalUnit,  // Habit unit
    );

    // Add to database or perform other actions with the new Task
    int value = await _taskController.addTask(task: newTask);
    print("Task added with id: $value");
  }
  _getDateFromUser() async {
    DateTime? _pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2015),
      lastDate: DateTime(2030),
    );
    if (_pickedDate != null) {
      setState(() {
        _selectedDate = _pickedDate;
      });
    } else {
      print("It's null or something is wrong");
    }
  }
  _getTimeFromUser({required bool isStartTime}) async {
    TimeOfDay? _pickedTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: isStartTime
          ? TimeOfDay.fromDateTime(DateTime.now())
          : TimeOfDay.fromDateTime(DateTime.now().add(const Duration(minutes: 15))),
    );
    if (_pickedTime != null) {
      String _formattedTime = _pickedTime.format(context);
      if (isStartTime) {
        setState(() => _startTime = _formattedTime);
      } else {
        setState(() => _endTime = _formattedTime);
      }
    }
  }
}
