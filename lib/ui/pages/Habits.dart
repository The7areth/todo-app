import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:untitled/controllers/task_controller.dart';
import 'package:untitled/models/task.dart';
import 'package:untitled/services/notification_services.dart';
import 'package:untitled/services/theme_services.dart';
import 'package:untitled/ui/pages/add_habit_page.dart';
import 'package:untitled/ui/size_config.dart';
import 'package:untitled/ui/theme.dart';
import 'package:untitled/ui/widgets/button.dart';
import 'package:untitled/ui/widgets/task_tile.dart';

class HabitsPage extends StatefulWidget {
  const HabitsPage({super.key});

  @override
  State<HabitsPage> createState() => _HabitsPageState();
}

class _HabitsPageState extends State<HabitsPage> {
  int _selectedIndex = 1; // Initialize it to the Habits tab
  late NotifyHelper notifyHelper;
  DateTime _selectedDate = DateTime.now();
  final TaskController _taskController = Get.put(TaskController());

  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.requestAndroidPermissions();
    notifyHelper.initializationNotification();
    _taskController.getTasks(); // Load tasks
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: context.theme.colorScheme.background,
      appBar: _buildAppBar(),
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: Column(
        children: [
          _buildAddTaskBar(),
          _buildAddDateBar(),
          const SizedBox(height: 6),
          _buildTaskList(),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          ThemeServices().switchTheme();
        },
        icon: Icon(
          Get.isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_round_outlined,
          size: 24,
          color: Get.isDarkMode ? Colors.white : darkGreyClr,
        ),
      ),
      elevation: 0,
      backgroundColor: context.theme.colorScheme.background,
      actions: [
        IconButton(
          onPressed: () {
            notifyHelper.cancelAllNotification();
            _taskController.deleteAllTasks();
          },
          icon: Icon(
            Icons.cleaning_services_outlined,
            size: 24,
            color: Get.isDarkMode ? Colors.white : darkGreyClr,
          ),
        ),
        const CircleAvatar(
          backgroundImage: AssetImage("images/person.jpeg"),
          radius: 18,
        ),
        const SizedBox(width: 20),
      ],
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.water_drop),
          label: 'Habits',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.red[300],
      onTap: (index) => setState(() {
        _selectedIndex = index; // Update the selected tab
      }),
    );
  }

  Widget _buildAddTaskBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(DateFormat.yMMMMd().format(DateTime.now()), style: headingStyle),
              Text("Today", style: headingStyle),
            ],
          ),
          MyButton(
            label: "+ Add Habit",
            onTap: () async {
              await Get.to(AddHabitPage());
              _taskController.getTasks(); // Refresh task list after adding
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAddDateBar() {
    return Container(
      margin: const EdgeInsets.only(top: 6, left: 20),
      child: DatePicker(
        DateTime.now(),
        width: 70,
        height: 100,
        initialSelectedDate: DateTime.now(),
        selectedTextColor: Colors.white,
        selectionColor: primaryClr,
        dateTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(color: Colors.grey, fontSize: 20, fontWeight: FontWeight.w600),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w600),
        ),
        onDateChange: (newDate) {
          setState(() {
            _selectedDate = newDate; // Update the selected date
          });
        },
      ),
    );
  }

  Future<void> _onRefresh() async {
    _taskController.getTasks(); // Refresh task list on pull-down
  }

  Widget _buildTaskList() {
    return Expanded(
      child: Obx(() {
        if (_taskController.taskList.isEmpty) {
          return _noTaskMsg();
        } else {
          return RefreshIndicator(
            onRefresh: _onRefresh,
            child: ListView.builder(
              scrollDirection: SizeConfig.orientation == Orientation.landscape ? Axis.horizontal : Axis.vertical,
              itemCount: _taskController.taskList.length,
              itemBuilder: (BuildContext context, int index) {
                var task = _taskController.taskList[index];

                // Check if the task is to be displayed based on selected date
                if (_shouldDisplayTask(task)) {
                  notifyHelper.scheduledNotification(
                    int.parse(task.startTime!.split(":")[0]),
                    int.parse(task.startTime!.split(":")[1]),
                    task,
                  );
                  return _buildAnimatedTaskTile(task, index);
                } else {
                  return const SizedBox.shrink(); // No task to show
                }
              },
            ),
          );
        }
      }),
    );
  }

  bool _shouldDisplayTask(Task task) {
    // For repeating on specific days of the week
    List<String> selectedDays = task.repeat!.split(',');
    String selectedWeekday = DateFormat('E').format(_selectedDate).substring(0, 1);

    return selectedDays.contains(selectedWeekday) ||
        task.date == DateFormat.yMd().format(_selectedDate) ||
        task.repeat == "Daily";
  }

  Widget _buildAnimatedTaskTile(Task task, int index) {
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: const Duration(milliseconds: 1000),
      child: SlideAnimation(
        horizontalOffset: 300,
        child: FadeInAnimation(
          child: GestureDetector(
            onTap: () => showBottomSheet(context, task),
            child: TaskTile(task),
          ),
        ),
      ),
    );
  }

  Widget _noTaskMsg() {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 2000),
          child: RefreshIndicator(
            onRefresh: _onRefresh,
            child: SingleChildScrollView(
              child: Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                direction: SizeConfig.orientation == Orientation.landscape ? Axis.horizontal : Axis.vertical,
                children: [
                  SizeConfig.orientation == Orientation.landscape
                      ? const SizedBox(height: 6)
                      : const SizedBox(height: 220),
                  SvgPicture.asset(
                    "images/task.svg",
                    color: primaryClr.withOpacity(0.5),
                    height: 90,
                    semanticsLabel: "Task",
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: Text(
                      "You don't have any Habits on this day!\nAdd new habits that keep you close to your goals :)",
                      style: subTitleStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizeConfig.orientation == Orientation.landscape
                      ? const SizedBox(height: 120)
                      : const SizedBox(height: 180),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(SingleChildScrollView(
      child: Column(
        children: [
          Text(task.title!, style: const TextStyle(fontSize: 20)),
          // Add other information you need from task
        ],
      ),
    ));
  }
}
