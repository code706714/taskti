import 'dart:io';

import 'package:flutter/material.dart';
import 'package:taskati/core/constants/app_images.dart';
import 'package:taskati/core/functions/naviagtion.dart';
import 'package:taskati/core/services/local_helper.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_styles.dart';
import 'package:taskati/features/acount/acount_sreen.dart';


class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        pushTo(context,  AcountSreen());
      } ,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hello, ${LocalHelper.getData(LocalHelper.kName)}",
                  style: TextStyles.titleStyle(color: AppColors.primaryColor),
                ),
                Text('Have a Nice day', style: TextStyles.bodyStyle()),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              LocalHelper.changeTheme();
            },
            icon: const Icon(Icons.dark_mode, color: AppColors.orangeColor),
          ),
          CircleAvatar(
            radius: 26,
            backgroundColor: AppColors.primaryColor,
            backgroundImage: LocalHelper.getData(LocalHelper.kImage) != null
                ? FileImage(File(LocalHelper.getData(LocalHelper.kImage)))
                : AssetImage(AppImages.emptyUser),
          ),
        ],
      ),
    );
  }
}
