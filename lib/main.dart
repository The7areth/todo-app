import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:get/get.dart';
=======
import 'package:get/get_navigation/src/root/get_material_app.dart';
>>>>>>> 3228cf64149e5868d9b162b36e51efef35ac2200
import 'package:get_storage/get_storage.dart';
import 'package:untitled/db/db_helper.dart';
import 'package:untitled/services/notification_services.dart';
import 'package:untitled/services/theme_services.dart';
import 'package:untitled/ui/pages/Habits.dart';
<<<<<<< HEAD
import 'package:untitled/ui/pages/Main_menu.dart';
=======
>>>>>>> 3228cf64149e5868d9b162b36e51efef35ac2200
import 'package:untitled/ui/pages/Signin_login.dart';
import 'package:untitled/ui/pages/notification_screen.dart';
import 'package:untitled/ui/theme.dart';
import 'package:untitled/ui/widgets/button.dart';
import 'ui/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDb();
<<<<<<< HEAD
  await GetStorage.init(); // Initialize GetStorage for theme persistence
=======
  await GetStorage.init();
>>>>>>> 3228cf64149e5868d9b162b36e51efef35ac2200
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
<<<<<<< HEAD

=======
>>>>>>> 3228cf64149e5868d9b162b36e51efef35ac2200
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
<<<<<<< HEAD
      theme: Themes.light,  // Define the light theme
      darkTheme: Themes.dark, // Define the dark theme
      themeMode: ThemeServices().theme, // Theme mode is controlled by ThemeServices
      home: MainPage(), // Your main page
=======
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeServices().theme,
      home: SignInPage()
>>>>>>> 3228cf64149e5868d9b162b36e51efef35ac2200
    );
  }
}
