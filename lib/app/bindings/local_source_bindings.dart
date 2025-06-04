import 'dart:io';

import 'package:get/get.dart';
import 'package:myapp/app/datas/local/backend_dummy.dart';
import 'package:myapp/app/datas/local/device_dummy.dart';
import 'package:myapp/app/datas/remote/auth_data_source_impl.dart';
import 'package:myapp/app/datas/remote/backend_data_source_impl.dart';
import 'package:myapp/app/datas/remote/device_data_source_impl.dart';
import 'package:myapp/app/datas/remote/device_data_source_serial.dart';
import 'package:myapp/app/datas/source/backend_data_source.dart';
import 'package:myapp/app/datas/source/device_data_source.dart';

import '../datas/local/auth_dummy.dart';
import '../datas/source/auth_data_source.dart';

class LocalSourceBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<AuthDataSource>(
      AuthDataSourceImpl(),
      tag: (AuthDataSource).toString(),
      permanent: true,
    );
    if (Platform.isIOS) {
      Get.put<DeviceDataSource>(
        DeviceDummy(),
        tag: (DeviceDataSource).toString(),
        permanent: true,
      );
    } else if (Platform.isAndroid) {
      Get.put<DeviceDataSource>(
        DeviceDummy(),
        tag: (DeviceDataSource).toString(),
        permanent: true,
      );
    }
    Get.put<BackendDataSource>(
      BackendDataSourceImpl(),
      tag: (BackendDataSource).toString(),
      permanent: true,
    );
  }
}
