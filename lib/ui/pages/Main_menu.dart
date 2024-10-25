import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/services/theme_services.dart';
import 'package:untitled/ui/pages/profile_settings_page.dart';
import 'package:untitled/controllers/task_controller.dart'; // Assuming TaskController handles task deletion
import 'package:untitled/services/notification_services.dart'; // Assuming NotificationService handles notifications
import 'package:untitled/ui/pages/projects_page.dart';
import 'package:untitled/ui/pages/reward_page.dart';
import '../../controllers/habit_controller.dart';
import 'home_page.dart';
import 'habits.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const HabitsPage(),
    ProjectPage(),
  ];

  final TaskController _taskController = Get.put(TaskController()); // Task Controller
  final HabitController _habitController = Get.put(HabitController()); // Task Controller
  final NotifyHelper notifyHelper = Get.put(NotifyHelper()); // Notification Helper

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Function to show the confirmation dialog
  void _showWipeConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Wipe"),
          content: const Text("Are you sure you want to wipe all tasks? This action cannot be undone."),
          actions: [
            TextButton(
              onPressed: () {
                // If the user cancels, just close the dialog
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                // If the user confirms, proceed with wiping tasks
                notifyHelper.cancelAllNotification(); // Cancel all notifications
                _taskController.deleteAllTasks();
                _habitController.deleteAllHabit();
                // Delete all tasks
                Get.snackbar(
                  "Tasks Cleared",
                  "All tasks have been wiped successfully!",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                );
                Navigator.of(context).pop(); // Close the dialog after wiping
              },
              child: const Text("Wipe"),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TickTasker'),
        // Adding the action button beside the AppBar (on the right side)
        actions: [
          IconButton(
            onPressed: () {
              // Show the confirmation dialog before wiping tasks
              _showWipeConfirmationDialog(context);
            },
            icon: Icon(
              Icons.cleaning_services_outlined,
              size: 24,
              color: Get.isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.task),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.water_drop),
            label: 'Habits',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_box),
            label: 'Projects',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF4e5ae8),
        onTap: _onItemTapped,
      ),
      // Adding the Drawer here
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Profile Settings'),
              onTap: () {
                Get.to(() => ProfileSettingsPage());
              },
            ),
            ListTile(
              leading: const Icon(Icons.brightness_6),
              title: const Text('Dark Mode'),
              trailing: Switch(
                value: Get.isDarkMode, // GetX property for checking current mode
                onChanged: (value) {
                  ThemeServices().switchTheme(); // Toggles the theme
                },
              ),
            ),
            ListTile(
              leading: Icon(Icons.card_giftcard),
              title: Text('Rewards'),  // Add Rewards page to the drawer
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(context, MaterialPageRoute(builder: (context) => RewardPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
