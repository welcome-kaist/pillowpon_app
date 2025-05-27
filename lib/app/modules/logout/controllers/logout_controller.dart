import 'dart:ui';

import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../routes/app_pages.dart';

class LogoutController extends GetxController {
  VoidCallback goLogin() {
    return () {
      Get.toNamed(Routes.LOGIN);
    };
  }

  VoidCallback goRegister() {
    return () {
      Get.toNamed(Routes.REGISTER);
    };
  }
}
