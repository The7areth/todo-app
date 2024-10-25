// import 'package:date_picker_timeline/date_picker_timeline.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:untitled/controllers/task_controller.dart';
// import 'package:untitled/models/task.dart';
// import 'package:untitled/services/notification_services.dart';
// import 'package:untitled/services/theme_services.dart';
// import 'package:untitled/ui/pages/add_habit_page.dart';
// import 'package:untitled/ui/size_config.dart';
// import 'package:untitled/ui/theme.dart';
// import 'package:untitled/ui/widgets/button.dart';
// import 'package:untitled/ui/widgets/task_tile.dart';
// import 'package:untitled/controllers/habit_controller.dart';
// import 'package:untitled/models/habit.dart';
//
// import '../widgets/habit_tile.dart';
//
//
//
//
//
// class HabitsPage extends StatefulWidget {
//   const HabitsPage({super.key});
//
//   @override
//   State<HabitsPage> createState() => _HabitsPageState();
// }
//
// class _HabitsPageState extends State<HabitsPage> {
//   int _selectedIndex = 1; // Initialize it to the Habits tab
//   late NotifyHelper notifyHelper;
//   DateTime _selectedDate = DateTime.now();
//   final HabitsController _habitController = Get.put(HabitsController());
//
//
//   @override
//   void initState() {
//     super.initState();
//     notifyHelper = NotifyHelper();
//     notifyHelper.requestAndroidPermissions();
//     notifyHelper.initializationNotification();
//     _habitController.getHabit();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     return Scaffold(
//       backgroundColor: context.theme.colorScheme.background,
//       appBar: null,
//       body: Column(
//         children: [
//           _buildAddTaskBar(),
//           _buildAddDateBar(),
//           const SizedBox(height: 6),
//           _buildTaskList(),
//         ],
//       ),
//     );
//   }
//
//   AppBar _buildAppBar() {
//     return AppBar(
//       leading: IconButton(
//         onPressed: () {
//           ThemeServices().switchTheme();
//         },
//         icon: Icon(
//           Get.isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_round_outlined,
//           size: 24,
//           color: Get.isDarkMode ? Colors.white : darkGreyClr,
//         ),
//       ),
//       elevation: 0,
//       backgroundColor: context.theme.colorScheme.background,
//       actions: [
//         IconButton(
//           onPressed: () {
//             notifyHelper.cancelAllNotification();
//             _habitController.deleteAllHabit();
//           },
//           icon: Icon(
//             Icons.cleaning_services_outlined,
//             size: 24,
//             color: Get.isDarkMode ? Colors.white : darkGreyClr,
//           ),
//         ),
//         const CircleAvatar(
//           backgroundImage: AssetImage("images/person.jpeg"),
//           radius: 18,
//         ),
//         const SizedBox(width: 20),
//       ],
//     );
//   }
//
//   Widget _buildAddTaskBar() {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(DateFormat.yMMMMd().format(DateTime.now()), style: headingStyle),
//               Text("Today", style: headingStyle),
//             ],
//           ),
//           MyButton(
//             label: "+ Add Habit",
//             onTap: () async {
//               await Get.to(AddHabitPage());
//               _habitController.getHabit();
//             },
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildAddDateBar() {
//     return Container(
//       margin: const EdgeInsets.only(top: 6, left: 20),
//       child: DatePicker(
//         DateTime.now(),
//         width: 70,
//         height: 100,
//         initialSelectedDate: DateTime.now(),
//         selectedTextColor: Colors.white,
//         selectionColor: primaryClr,
//         dateTextStyle: GoogleFonts.lato(
//           textStyle: const TextStyle(color: Colors.grey, fontSize: 20, fontWeight: FontWeight.w600),
//         ),
//         dayTextStyle: GoogleFonts.lato(
//           textStyle: const TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w600),
//         ),
//         monthTextStyle: GoogleFonts.lato(
//           textStyle: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w600),
//         ),
//         onDateChange: (newDate) {
//           setState(() {
//             _selectedDate = newDate; // Update the selected date
//           });
//         },
//       ),
//     );
//   }
//
//   Future<void> _onRefresh() async {
//     _habitController.getHabit(); // Refresh task list on pull-down
//   }
//
//   Widget _buildTaskList() {
//     return Expanded(
//       child: Obx(() {
//         if (_habitController.habitList.isEmpty) {
//           return _noHabitkMsg();
//         } else {
//           return RefreshIndicator(
//             onRefresh: _onRefresh,
//             child: ListView.builder(
//               scrollDirection: SizeConfig.orientation == Orientation.landscape ? Axis.horizontal : Axis.vertical,
//               itemCount: _habitController.habitList.length,
//               itemBuilder: (BuildContext context, int index) {
//                 var task = _habitController.habitList[index];
//
//                 // Check if the task is to be displayed based on selected date
//                 if (_shouldDisplayHabit(habit)) {
//                   notifyHelper.scheduledNotification(
//                     int.parse(habit.startTime!.split(":")[0]),
//                     int.parse(habit.startTime!.split(":")[1]),
//                     habit,
//                   );
//                   return _buildAnimatedHabitTile(habit, index);
//                 } else {
//                   return const SizedBox.shrink(); // No task to show
//                 }
//               },
//             ),
//           );
//         }
//       }),
//     );
//   }
//
//   // bool _shouldDisplayHabit(Habit habit) {
//   //   // For repeating on specific days of the week
//   //   List<String> selectedDays = habit.repeat!.split(',');
//   //   String selectedWeekday = DateFormat('E').format(_selectedDate).substring(0, 1);
//   //
//   //   return selectedDays.contains(selectedWeekday) ||
//   //       habit.date == DateFormat.yMd().format(_selectedDate) ||
//   //       habit.repeat == "Daily";
//   // }
//
//   Widget _buildAnimatedHabitTile(Habit habit, int index) {
//     return AnimationConfiguration.staggeredList(
//       position: index,
//       duration: const Duration(milliseconds: 1000),
//       child: SlideAnimation(
//         horizontalOffset: 300,
//         child: FadeInAnimation(
//           child: GestureDetector(
//             onTap: () => showBottomSheet(context, habit),
//             child: HabitTile(habit),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _noHabitkMsg() {
//     return Stack(
//       children: [
//         AnimatedPositioned(
//           duration: const Duration(milliseconds: 2000),
//           child: RefreshIndicator(
//             onRefresh: _onRefresh,
//             child: SingleChildScrollView(
//               child: Wrap(
//                 alignment: WrapAlignment.center,
//                 crossAxisAlignment: WrapCrossAlignment.center,
//                 direction: SizeConfig.orientation == Orientation.landscape ? Axis.horizontal : Axis.vertical,
//                 children: [
//                   SizeConfig.orientation == Orientation.landscape
//                       ? const SizedBox(height: 6)
//                       : const SizedBox(height: 220),
//                   SvgPicture.asset(
//                     "images/task.svg",
//                     color: primaryClr.withOpacity(0.5),
//                     height: 90,
//                     semanticsLabel: "Task",
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
//                     child: Text(
//                       "You don't have any Habits on this day!\nAdd new habits that keep you close to your goals :)",
//                       style: subTitleStyle,
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                   SizeConfig.orientation == Orientation.landscape
//                       ? const SizedBox(height: 120)
//                       : const SizedBox(height: 180),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   void showBottomSheet(BuildContext context, Task task) {
//     Get.bottomSheet(SingleChildScrollView(
//       child: Column(
//         children: [
//           Text(task.title!, style: const TextStyle(fontSize: 20)),
//           // Add other information you need from task
//         ],
//       ),
//     ));
//   }
// }
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:untitled/services/notification_services.dart';
import 'package:untitled/ui/pages/add_habit_page.dart';
import 'package:untitled/ui/size_config.dart';
import 'package:untitled/ui/theme.dart';
import 'package:untitled/ui/widgets/button.dart';
import '../../controllers/habit_controller.dart';
import '../../models/habit.dart';
import '../widgets/habit_tile.dart';
import 'check_in_page.dart'; // Adjust the path as necessary


class HabitsPage extends StatefulWidget {
  const HabitsPage({Key? key}) : super(key: key);

  @override
  State<HabitsPage> createState() => _HomePageState();
}

int _selectedIndex = 0; // Initialize it to 0
class _HomePageState extends State<HabitsPage> {
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected tab
    });
  }
  late NotifyHelper notifyHelper;
  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.requestAndroidPermissions();
    notifyHelper.initializationNotification();
    _habitController.getHabit();
  }

  DateTime _selectedDate = DateTime.now();
  final HabitController _habitController = Get.put(HabitController());
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: context.theme.colorScheme.background,
      appBar: null,
      body: Column(
        children: [
          _addHabitBar(),
          _addDateBar(),
          const SizedBox(
            height: 6,
          ),
          _showHabits(),
        ],
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.colorScheme.background,
      actions: [],
    );
  }

  _addHabitBar() {
    return Container(
      margin: const EdgeInsets.only(
        left: 20,
        right: 10,
        top: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(
                  DateTime.now(),
                ),
                style: headingStyle,
              ),
              Text(
                "Today",
                style: headingStyle,
              ),
            ],
          ),
          MyButton(
            label: "+ Add Habit",
            onTap: () async {
              await Get.to(AddHabitPage());
              _habitController.getHabit();
            },
          )
        ],
      ),
    );
  }


  _addDateBar() {
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
          textStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        onDateChange: (newDate) {
          setState(() {
            _selectedDate = newDate;
          });
        },
      ),
    );
  }

  Future<void> _onRefresh() async {
    _habitController.getHabit();
  }

  _showHabits() {
    return Expanded(
      child: Obx(() {
        if (_habitController.habitList.isEmpty) {
          return _noHabitMsg();
        } else {
          return RefreshIndicator(
            onRefresh: _onRefresh,
            child: ListView.builder(
              scrollDirection: SizeConfig.orientation == Orientation.landscape
                  ? Axis.horizontal
                  : Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                var habit = _habitController.habitList[index];
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 1000),
                    child: SlideAnimation(
                      horizontalOffset: 300,
                      child: FadeInAnimation(
                        child: GestureDetector(
                          onTap: () => showBottomSheet(context, habit),
                          child: HabitTile(habit),
                        ),
                      ),
                    ),
                  );
              },
              itemCount: _habitController.habitList.length,

            ),
          );
        }
      }),

    );
  }

  _noHabitMsg() {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: Duration(milliseconds: 2000),
          child: RefreshIndicator(
            onRefresh: _onRefresh,
            child: SingleChildScrollView(
              child: Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                direction: SizeConfig.orientation == Orientation.landscape
                    ? Axis.horizontal
                    : Axis.vertical,
                children: [
                  SizeConfig.orientation == Orientation.landscape
                      ? const SizedBox(
                    height: 6,
                  )
                      : const SizedBox(
                    height: 220,
                  ),
                  SvgPicture.asset(
                    "images/task.svg",
                    color: primaryClr.withOpacity(0.5),
                    height: 90,
                    semanticsLabel: "Habit",
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 10,
                    ),
                    child: Text(
                      "You don't have any Habits yet!\nAdd new Habits to make your days productive",
                      style: subTitleStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizeConfig.orientation == Orientation.landscape
                      ? const SizedBox(
                    height: 120,
                  )
                      : const SizedBox(
                    height: 180,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  showBottomSheet(BuildContext context, Habit habit) {
    Get.bottomSheet(SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(top: 4),
        width: SizeConfig.screenWidth,
        height: (SizeConfig.orientation == Orientation.landscape)
            ? (habit.isCompleted == 1
            ? SizeConfig.screenHeight * 0.6
            : SizeConfig.screenHeight * 0.8)
            : (habit.isCompleted == 1
            ? SizeConfig.screenHeight * 0.30
            : SizeConfig.screenHeight * 0.39),
        color: Get.isDarkMode ? darkHeaderClr : Colors.white,
        child: Column(
          children: [
            Flexible(
              child: Container(
                height: 6,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            habit.isCompleted == 1
                ? Container()
                : _buildBottomSheet(
              label: "Habit Completed",
              onTap: () {
                notifyHelper.cancelHabitNotification(habit);
                _habitController.markHabitCompleted(habit.id!);
                Get.back();
              },
              clr: primaryClr,
            ),
            _buildBottomSheet(
              label: "Delete Habit",
              onTap: () {
                notifyHelper.cancelHabitNotification(habit);
                _habitController.deleteHabit(habit);
                Get.back();
              },
              clr: Colors.red[300]!,
            ),
            Divider(
              color: Get.isDarkMode ? Colors.grey : darkGreyClr,
            ),
            _buildBottomSheet(
              label: "Habit Details",
              onTap: () {
                // Navigate to HabitCheckInPage when the BottomSheet is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HabitCheckInPage(habitId: 1)),
                );
              },
              clr: Colors.red[300]!,
            ),
            Divider(
              color: Get.isDarkMode ? Colors.grey : darkGreyClr,
            ),
            _buildBottomSheet(
              label: "Cancel",
              onTap: () {
                Get.back();
              },
              clr: primaryClr,
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    ));
  }

  _buildBottomSheet(
      {required String label,
        required Function() onTap,
        required Color clr,
        bool isClose = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 65,
        width: SizeConfig.screenWidth * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isClose
                ? Get.isDarkMode
                ? Colors.grey[600]!
                : Colors.grey[300]!
                : clr,
          ),
          borderRadius: BorderRadius.circular(20),
          color: isClose ? Colors.transparent : clr,
        ),
        child: Center(
          child: Text(
            label,
            style: isClose
                ? titleStyle
                : titleStyle.copyWith(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );

  }
}

