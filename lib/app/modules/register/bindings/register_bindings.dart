import 'package:get/get.dart';

import '../controllers/register_controller.dart';

class RegisterBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<RegisterController>(RegisterController());
  }
}
