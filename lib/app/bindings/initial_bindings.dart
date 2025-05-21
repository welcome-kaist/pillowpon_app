import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:myapp/app/cores/services/auth_service.dart';
import 'package:myapp/app/cores/services/auth_service_impl.dart';
import 'package:myapp/app/cores/services/data_service.dart';
import 'package:myapp/app/cores/services/data_service_impl.dart';
import 'package:myapp/app/cores/services/device_service.dart';
import 'package:myapp/app/cores/services/device_service_impl.dart';

import 'local_source_bindings.dart';

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<Logger>(Logger());
    LocalSourceBindings().dependencies();
    // RepositoryBindings().dependencies();
    Get.put<AuthService>(AuthServiceImpl());
    Get.put<DataService>(DataServiceImpl());
    Get.put<DeviceService>(DeviceServiceImpl());
  }
}
