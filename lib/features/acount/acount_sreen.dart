import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskati/core/constants/app_images.dart';
import 'package:taskati/core/functions/dialogs.dart';
import 'package:taskati/core/functions/naviagtion.dart';
import 'package:taskati/core/services/local_helper.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/widgets/custom_text_field.dart';
import 'package:taskati/core/widgets/main_button.dart';
import 'package:taskati/features/home/page/home_screen.dart';

class AcountSreen extends StatefulWidget {
  const AcountSreen({super.key});

  @override
  State<AcountSreen> createState() => _AcountscreenState();
}

class _AcountscreenState extends State<AcountSreen> {
  String imagePath = '';
  var nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              if (imagePath.isNotEmpty && nameController.text.isNotEmpty) {
                LocalHelper.putUserData(nameController.text, imagePath);
                pushWithReplacement(context, const HomeScreen());
              } else if (imagePath.isNotEmpty && nameController.text.isEmpty) {
                showErrorDialog(context, 'Please Enter Your Name');
              } else if (imagePath.isEmpty && nameController.text.isNotEmpty) {
                showErrorDialog(context, 'Please Upload Your Image');
              } else {
                showErrorDialog(
                  context,
                  'Please Enter Your Name and Upload Your Image',
                );
              }
            },
            child: const Text('Done'),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // صورة المستخدم + أيقونة الكاميرا
              Stack(
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundColor: AppColors.primaryColor.withOpacity(0.2),
                    backgroundImage: imagePath.isNotEmpty
                        ? FileImage(File(imagePath))
                        : AssetImage(AppImages.emptyUser) as ImageProvider,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          builder: (_) {
                            return Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  MainButton(
                                    text: "Upload from Camera",
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      await uploadImage(isCamera: true);
                                    },
                                  ),
                                  const Gap(15),
                                  MainButton(
                                    text: "Upload from Gallery",
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      await uploadImage(isCamera: false);
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: AppColors.primaryColor,
                        child: const Icon(Icons.camera_alt, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(40),

              // إدخال الاسم + زرار تحديث
              Row(
                children: [
                  Expanded(
                    child: Text(
                      nameController.text.isNotEmpty
                          ? nameController.text
                          : "Enter Your Name",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit, color: AppColors.primaryColor),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        builder: (_) {
                          return Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomTextField(
                                  controller: nameController,
                                  hint: "Enter Your Name",
                                ),
                                const Gap(20),
                                MainButton(
                                  text: "Update Your Name",
                                  onPressed: () {
                                    setState(() {});
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> uploadImage({required bool isCamera}) async {
    XFile? file = await ImagePicker().pickImage(
      source: isCamera ? ImageSource.camera : ImageSource.gallery,
    );
    if (file != null) {
      setState(() {
        imagePath = file.path;
      });
    }
  }
}
