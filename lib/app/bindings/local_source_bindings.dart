import 'package:get/get.dart';
import 'package:myapp/app/datas/local/device_dummy.dart';
import 'package:myapp/app/datas/remote/device_data_source_impl.dart';
import 'package:myapp/app/datas/source/device_data_source.dart';

import '../datas/local/auth_dummy.dart';
import '../datas/source/auth_data_source.dart';

class LocalSourceBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<AuthDataSource>(
      AuthDummy(),
      tag: (AuthDataSource).toString(),
      permanent: true,
    );
    Get.put<DeviceDataSource>(
      DeviceDataSourceImpl(),
      tag: (DeviceDataSource).toString(),
      permanent: true,
    );
  }
}
