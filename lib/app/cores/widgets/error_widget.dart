import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../values/app_colors.dart';
import 'text.dart';

class ErrorSnackbar {
  static show(String message) => Get.snackbar("", "",
      duration: const Duration(seconds: 3),
      backgroundColor: AppColors.primaryWhite.withOpacity(0.8),
      titleText: PillowponText.mob14w500(text: "error"),
      messageText: PillowponText.mob14w500(
        text: message,
      ),
      margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
      snackPosition: SnackPosition.BOTTOM);
}

class ErrorDialog {
  static show(String title, String message) => Get.dialog(CupertinoAlertDialog(
    title: Text(title),
    content: Text(message),
    actions: [
      CupertinoDialogAction(
        child: const Text("OK"),
        onPressed: () => Get.back(),
      )
    ],
  ));
}