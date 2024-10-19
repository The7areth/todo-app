import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:untitled/db/db_helper.dart';
import 'package:untitled/services/notification_services.dart';
import 'package:untitled/services/theme_services.dart';
import 'package:untitled/ui/pages/Habits.dart';
import 'package:untitled/ui/pages/Main_menu.dart';
import 'package:untitled/ui/pages/Signin_login.dart';
import 'package:untitled/ui/pages/notification_screen.dart';
import 'package:untitled/ui/theme.dart';
import 'package:untitled/ui/widgets/button.dart';
import 'ui/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDb();
  await GetStorage.init(); // Initialize GetStorage for theme persistence
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: Themes.light,  // Define the light theme
      darkTheme: Themes.dark, // Define the dark theme
      themeMode: ThemeServices().theme, // Theme mode is controlled by ThemeServices
      home: MainPage(), // Your main page
    );
  }
}
