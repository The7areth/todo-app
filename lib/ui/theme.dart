import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const Color bluishClr = Color(0xFF4e5ae8);
const Color orangeClr = Color(0xCFFF8746);
const Color pinkClr = Color(0xFFff4667);
const Color white = Colors.white;
const primaryClr = bluishClr;
const Color darkGreyClr = Color(0xFF121212);
const Color darkHeaderClr = Color(0xFF424242);

class Themes {
  static final light = ThemeData(
    primaryColor: primaryClr,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryClr,
      brightness: Brightness.light,
    ),
    useMaterial3: true,
  );
  static final dark = ThemeData(
    primaryColor: darkGreyClr,
    colorScheme: ColorScheme.fromSeed(
      seedColor: darkGreyClr,
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
  );
}
TextStyle get headingStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      color: Get.isDarkMode ? Colors.white : Colors.black,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
  );
}

TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      color: Get.isDarkMode ? Colors.white : Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  );
}

TextStyle get titleStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      color: Get.isDarkMode ? Colors.white : Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
  );
}

TextStyle get subTitleStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      color: Get.isDarkMode ? Colors.white : Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
  );
}

TextStyle get bodyStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      color: Get.isDarkMode ? Colors.white : Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
  );
}

TextStyle get body2Style {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      color: Get.isDarkMode ? Colors.grey[200] : Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
  );
}
<<<<<<< HEAD

class ThemeController extends GetxController {
  RxBool isDarkMode = false.obs;

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
  }

  ThemeMode get currentTheme => isDarkMode.value ? ThemeMode.dark : ThemeMode.light;
}
=======
>>>>>>> 3228cf64149e5868d9b162b36e51efef35ac2200
