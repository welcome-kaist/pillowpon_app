import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:myapp/app/cores/models/pillowpon.dart';
import 'package:myapp/app/cores/services/data_service.dart';
import 'package:myapp/app/cores/utils/error_dialog.dart';
import 'package:myapp/app/modules/main/widgets/setting.dart';

import '../../../cores/services/auth_service.dart';
import '../../../cores/services/device_service.dart';
import '../widgets/device_dialog.dart';

class MainController extends GetxController {
  final Rx<int> _rxCurrentIndex = Rx<int>(2);

  int get currentIndex => _rxCurrentIndex.value;

  final Rx<bool> _rxIsConnected = Rx<bool>(false);

  bool get isConnected => _rxIsConnected.value;

  final Rx<bool> _rxIsDeviceDialogOpened = Rx<bool>(false);

  bool get isDeviceDialogOpened => _rxIsDeviceDialogOpened.value;

  final deviceService = Get.find<DeviceService>();

  final log = Get.find<Logger>();

  final backendService = Get.find<DataService>();

  final authService = Get.find<AuthService>();

  var scaffoldKey = GlobalKey<ScaffoldState>();

  final RxBool _rxIsSleeping = RxBool(false);
  bool get isSleeping => _rxIsSleeping.value;

  @override
  void onInit() {
    super.onInit();
  }

  void tabBarIndex(int index) {
    _rxCurrentIndex.value = index;
  }

  Future<void> openDeviceDialog() async {
    _rxIsDeviceDialogOpened.value = true;
    deviceService.loadDeviceList();
    Get.dialog(DeviceDialog()).then((_) {
      _rxIsDeviceDialogOpened.value = false;
    });
  }

  void closeDeviceDialog() {
    _rxIsDeviceDialogOpened.value = false;
  }

  void connectDevice(Pillowpon device) async {
    deviceService.connectDevice(device).then((isSuccess) {
      if (isSuccess) {
        _rxIsConnected(true);
        log.i("Connected to ${device.name}");
      } else {
        _rxIsConnected(false);
        log.e("Failed to connect to ${device.name}");
        ErrorDialog.show(
          "Connection Failed",
          "Failed to connect to ${device.name}",
        );
      }
    }).catchError((error) {
      _rxIsConnected(false);
      log.e("Error connecting to ${device.name}: $error");
      ErrorDialog.show(
        "Connection Error",
        "Error connecting to ${device.name}: $error",
      );
    });
    Get.back();
  }

  void setSleeping() {
    _rxIsSleeping(true);
    backendService.sleepScoreUpdateStream(authService.user!);
  }

  void onNotificationPressed() {
    Fluttertoast.showToast(msg: "개발중");
  }

  @override
  void onClose() {
    super.onClose();
  }
}
