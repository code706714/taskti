import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taskati/core/constants/task_colors.dart';
import 'package:taskati/core/functions/naviagtion.dart';
import 'package:taskati/core/models/task_model.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_styles.dart';
import 'package:taskati/features/add_edit_task/add_edit_task_screen.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    super.key,
    required this.model,
    required this.onDelete,
    required this.onComplete,
  });

  final TaskModel model;
  final Function() onDelete;
  final Function() onComplete;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      movementDuration: const Duration(milliseconds: 800),
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          onComplete();
        } else {
          onDelete();
        }
      },
      background: _buildComplete(),
      secondaryBackground: _buildDelete(),
      child: _buildTaskCard(context),
    );
  }

  Container _buildComplete() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(Icons.done, color: AppColors.whiteColor),
          Gap(5),
          Text(
            'Complete Task',
            style: TextStyles.bodyStyle(color: AppColors.whiteColor),
          ),
        ],
      ),
    );
  }

  Container _buildDelete() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.redColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(Icons.delete, color: AppColors.whiteColor),
          Gap(5),
          Text(
            'Delete Task',
            style: TextStyles.bodyStyle(color: AppColors.whiteColor),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        pushTo(context, AddEditTaskScreen(model: model));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: colors[model.color ?? 0],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          spacing: 8,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 5,
                children: [
                  Text(
                    model.title ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.bodyStyle(color: AppColors.whiteColor),
                  ),
                  Row(
                    spacing: 6,
                    children: [
                      Icon(
                        Icons.watch_later_outlined,
                        color: AppColors.whiteColor,
                        size: 19,
                      ),
                      Text(
                        '${model.startTime} : ${model.endTime}',
                        style: TextStyles.smallStyle(
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    (model.description?.isNotEmpty == true)
                        ? model.description ?? ''
                        : '--',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.bodyStyle(color: AppColors.whiteColor),
                  ),
                ],
              ),
            ),
            Container(width: 1, height: 60, color: AppColors.whiteColor),
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                model.isCompleted == true ? "COMPLETED" : 'TODO',
                style: TextStyles.smallStyle(
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
