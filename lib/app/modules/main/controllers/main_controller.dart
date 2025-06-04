import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:myapp/app/cores/models/pillowpon.dart';
import 'package:myapp/app/cores/services/data_service.dart';
import 'package:myapp/app/cores/utils/error_dialog.dart';
import 'package:myapp/app/modules/main/models/smart_alart.dart';

import '../../../cores/models/sleep_score.dart';
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

  final RxBool _rxIsOnboarding = RxBool(true);

  bool get isOnboarding => _rxIsOnboarding.value;

  final RxMap<int, SleepScore> _rxMonthlySleepScores = RxMap<int, SleepScore>();

  Map<int, SleepScore> get monthlySleepScores => _rxMonthlySleepScores.value;

  StreamSubscription? _loadDeviceListSubscription;
  StreamSubscription? _loadAndUploadMetadataSubscription;
  StreamSubscription? _sleepDepthUpdateSubscription;

  final Rx<SmartAlarm?> _rxSmartAlarm = Rx<SmartAlarm?>(null);

  SmartAlarm? get smartAlarm => _rxSmartAlarm.value;

  final RxList<SmartAlarm> _rxSmartAlarmList = RxList<SmartAlarm>.empty();

  List<SmartAlarm> get smartAlarmList => _rxSmartAlarmList;

  @override
  void onInit() {
    super.onInit();
  }

  set tabBarIndex(int index) {
    _rxCurrentIndex.value = index;
  }

  Future<void> openDeviceDialog() async {
    _rxIsDeviceDialogOpened.value = true;
    _loadDeviceListSubscription ??= deviceService.loadDeviceList();
    _loadDeviceListSubscription!.resume();
    Get.dialog(DeviceDialog()).then((_) {
      _rxIsDeviceDialogOpened.value = false;
      _loadDeviceListSubscription!.pause();
    });
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
    backendService.getMonthlySleepScores().then((data) {
      _rxMonthlySleepScores(data);
    });
    backendService.newSleepSession().then((_) {
      _rxIsOnboarding(false);
      _rxIsSleeping(true);
      _loadAndUploadMetadataSubscription ??=
          deviceService.loadAndUploadMetadata();
      _loadAndUploadMetadataSubscription!.resume();
      _sleepDepthUpdateSubscription ??= backendService.sleepDepthUpdateStream();
      _sleepDepthUpdateSubscription!.resume();
    });
  }

  void stopSleeping() async {
    backendService.stopSleepSession().then((result) {
      _rxIsSleeping(false);
      _loadAndUploadMetadataSubscription!.pause();
      _sleepDepthUpdateSubscription!.pause();
      Get.snackbar(
        "Your sleep score is ${result.score}",
        "start time : ${result.start_time}\n end time : ${result.end_time}",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    });
  }

  void onNotificationPressed() {
    Fluttertoast.showToast(msg: "개발중");
  }

  @override
  void onClose() {
    if (_loadDeviceListSubscription != null) {
      _loadDeviceListSubscription!.cancel();
    }
    if (_loadAndUploadMetadataSubscription != null) {
      _loadAndUploadMetadataSubscription!.cancel();
    }
    if (_sleepDepthUpdateSubscription != null) {
      _sleepDepthUpdateSubscription!.cancel();
    }
    super.onClose();
  }

  void setSmartAlarm(SmartAlarm smartAlarm) {
    _rxSmartAlarm(smartAlarm);
  }

  void saveSmartAlarm() {
    if (smartAlarm == null) {
      return;
    }
    if ((smartAlarm!.alartTime
        .subtract(const Duration(minutes: 30))
        .isAfter(DateTime.now()))) {
      smartAlarm!.setSmartAlart(() {
        if (backendService.sleepDepthList.last.depth < 30) {
          deviceService.activateAlarm(0);
        } else {
          smartAlarm!.stopAlart();
          smartAlarm!.setSmartAlart(() {
            deviceService.activateAlarm(0);
          }, Duration.zero);
        }
      }, const Duration(minutes: 30));
    } else {
      smartAlarm!.setSmartAlart(() {
        deviceService.activateAlarm(0);
      }, Duration.zero);
    }
    _rxSmartAlarmList.add(smartAlarm!);
  }
}
