import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:untitled/models/task.dart';
import 'package:untitled/ui/pages/notification_screen.dart';
import 'package:untitled/ui/theme.dart';

import '../models/habit.dart';

class NotifyHelper {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  initializationNotification() async {
    tz.initializeTimeZones();
    //  tz.setLocalLocation(tz.getLocation(timeZoneName));
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/appicon.jpeg');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin);
    void requestAndroidPermissions() {
      flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
    }

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );
  }

// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project

  void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
    }
    await Get.to(NotificationScreen(payload: payload!));
  }

  displayNotification({required String title, required String body}) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin
        .show(0, title, body, notificationDetails, payload: 'Default_Sound');
  }

  cancelNotification(Task task) async {
    await flutterLocalNotificationsPlugin.cancel(task.id!);
  }
  cancelHabitNotification(Habit habit) async {
    await flutterLocalNotificationsPlugin.cancel(habit.id!);
  }
  cancelAllNotification() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  scheduledNotification(int hour, int minutes, Task task) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      task.id!,
      task.title,
      task.note,
      //tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
      _nextInstanceOfTenAM(
          hour, minutes, task.remind!, task.repeat!, task.date!),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          "your channel id",
          "your channel name",
          channelDescription: 'your channel description',
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: '${task.title}|${task.note}|${task.startTime}|',
    );
  }

  tz.TZDateTime _nextInstanceOfTenAM(
      int hour, int minutes, int remind, String repeat, String date) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    var formattedDate = DateFormat.yMd().parse(date);
    final tz.TZDateTime fd = tz.TZDateTime.from(formattedDate, tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, fd.year, fd.month, fd.day, hour, minutes);

    scheduledDate = afterRemind(remind, scheduledDate)!;

    if (scheduledDate.isBefore(now)) {
      if (repeat == "Daily") {
        scheduledDate = tz.TZDateTime(tz.local, now.year, now.month,
            (formattedDate.day) + 1, hour, minutes);
      }
      if (repeat == "Weekly") {
        scheduledDate = tz.TZDateTime(tz.local, now.year, now.month,
            (formattedDate.day) + 7, hour, minutes);
      }
      if (repeat == "Monthly") {
        scheduledDate = tz.TZDateTime(tz.local, now.year,
            (formattedDate.month) + 1, formattedDate.day, hour, minutes);
      }
      scheduledDate = afterRemind(remind, scheduledDate)!;
    }

    print("final scheduledDate = $scheduledDate");
    return scheduledDate;
  }

  tz.TZDateTime? afterRemind(int remind, tz.TZDateTime scheduledDate) {
    tz.TZDateTime? scheduledDateE;
    if (remind == 5) {
      scheduledDateE = scheduledDate.subtract(const Duration(minutes: 5));
    }
    if (remind == 10) {
      scheduledDateE = scheduledDate.subtract(const Duration(minutes: 10));
    }
    if (remind == 15) {
      scheduledDateE = scheduledDate.subtract(const Duration(minutes: 15));
    }
    if (remind == 20) {
      scheduledDateE = scheduledDate.subtract(const Duration(minutes: 20));
    }return scheduledDateE;
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    Get.dialog(Text(body!));
  }

  void requestAndroidPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }
}
