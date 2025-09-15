import 'package:flutter/material.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_styles.dart';

showErrorDialog(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(20),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: AppColors.redColor,
      content: Text(
        message,
        style: TextStyles.bodyStyle(color: AppColors.whiteColor),
      ),
    ),
  );
}


 // showDialog(
                //   context: context,
                //   builder: (context) {
                //     return SimpleDialog(
                //       children: [
                //         MainButton(
                //           width: 300,
                //           onPressed: () async {
                //             await uploadImage(isCamera: true);
                //           },
                //           text: 'Upload From Camera',
                //         ),
                //         Gap(15),
                //         MainButton(
                //           width: 300,
                //           onPressed: () async {
                //             await uploadImage(isCamera: false);
                //           },
                //           text: 'Upload From Gallery',
                //         ),
                //       ],
                //     );
                //   },
                // );