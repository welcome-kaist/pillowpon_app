import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

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
