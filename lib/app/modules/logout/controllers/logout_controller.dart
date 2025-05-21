import 'dart:ui';

import 'package:get/get.dart';

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
