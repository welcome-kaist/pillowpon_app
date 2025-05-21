import 'package:get/get.dart';

import '../controllers/main_controller.dart';
import '../controllers/setting_controller.dart';

class MainBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<MainController>(MainController());
    Get.put<SettingController>(SettingController());
  }
}
