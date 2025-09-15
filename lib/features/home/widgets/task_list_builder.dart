import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:taskati/core/constants/app_images.dart';
import 'package:taskati/core/models/task_model.dart';
import 'package:taskati/core/services/local_helper.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_styles.dart';
import 'package:taskati/features/home/widgets/task_item.dart';

class TaskListBuilder extends StatefulWidget {
  const TaskListBuilder({super.key});

  @override
  State<TaskListBuilder> createState() => _TaskListBuilderState();
}

class _TaskListBuilderState extends State<TaskListBuilder> {
  String selectedDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          DatePicker(
            DateTime.now().subtract(const Duration(days: 1)),
            width: 70,
            height: 100,
            initialSelectedDate: DateTime.now(),
            selectionColor: AppColors.primaryColor,
            selectedTextColor: Colors.white,
            monthTextStyle: TextStyles.smallStyle(),
            dayTextStyle: TextStyles.smallStyle(),
            dateTextStyle: TextStyles.bodyStyle(fontWeight: FontWeight.w600),
            onDateChange: (date) {
              setState(() {
                selectedDate = DateFormat("yyyy-MM-dd").format(date);
              });
            },
          ),
          const Gap(15),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: LocalHelper.taskBox.listenable(),
              builder: (context, box, child) {
                List<TaskModel> tasks = []; // specific tasks for date
                for (var task in box.values) {
                  if (task.date == selectedDate) {
                    tasks.add(task);
                  }
                }
                if (tasks.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(AppImages.emptyJson),
                        Text('No Task Found', style: TextStyles.bodyStyle()),
                      ],
                    ),
                  );
                } else {
                  return ListView.separated(
                    itemBuilder: (context, index) {
                      return TaskItem(
                        model: tasks[index],
                        onComplete: () {
                          box.put(
                            tasks[index].id,
                            tasks[index].copyWith(isCompleted: true, color: 3),
                          );
                        },
                        onDelete: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog.adaptive(
                                title: const Text('Delete Task'),
                                content: const Text('Are you sure?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      box.delete(tasks[index].id);
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Delete'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      );
                    },
                    itemCount: tasks.length,
                    separatorBuilder: (context, index) => const Gap(10),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
