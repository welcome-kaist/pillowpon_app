import 'package:get/get.dart';

import '../controllers/logout_controller.dart';

class LogoutBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<LogoutController>(LogoutController());
  }
}
