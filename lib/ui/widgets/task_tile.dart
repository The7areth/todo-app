import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/models/task.dart';
import 'package:untitled/ui/size_config.dart';
import 'package:untitled/ui/theme.dart';

class TaskTile extends StatelessWidget {
  final Task task;

  const TaskTile(this.task, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: task.projectName != null && task.projectName!.isNotEmpty
            ? Border.all(color: Colors.blueAccent, width: 2)  // Colored stroke for project-related tasks
            : Border.all(color: Colors.transparent),
        color: Get.isDarkMode ? darkHeaderClr : Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            task.title!,
            style: GoogleFonts.lato(
              textStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Get.isDarkMode ? Colors.white : darkGreyClr,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.access_time_rounded,
                  color: Get.isDarkMode ? Colors.white : darkGreyClr),
              const SizedBox(width: 4),
              Text(
                "${task.startTime} - ${task.endTime}",
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    fontSize: 13,
                    color: Get.isDarkMode ? Colors.white : darkGreyClr,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            task.note!,
            style: GoogleFonts.lato(
              textStyle: TextStyle(
                fontSize: 15,
                color: Get.isDarkMode ? Colors.white : darkGreyClr,
              ),
            ),
          ),
          if (task.projectName != null && task.projectName!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              "Project: ${task.projectName}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.blueAccent,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

