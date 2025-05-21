import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../values/app_colors.dart';
import '../widgets/text.dart';

class ErrorSnackbar {
  static show(String message) => Get.snackbar("", "",
      duration: const Duration(milliseconds: 1200),
      backgroundColor: AppColors.primaryWhite.withOpacity(0.8),
      titleText: PillowponText.mob14w500(text: "error"),
      messageText: PillowponText.mob14w500(
        text: message,
      ),
      borderColor: AppColors.primaryRed,
      borderWidth: 1,
      margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
      snackPosition: SnackPosition.TOP);
}
