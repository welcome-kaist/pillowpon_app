import 'dart:async';

import 'package:get/get.dart';
import 'package:myapp/app/cores/models/pillowpon.dart';
import 'package:myapp/app/cores/models/pillowpon_metadata.dart';

abstract class DeviceService extends GetxService {
  List<Pillowpon> get deviceList;

  Pillowpon? get connectedDevice;

  StreamSubscription<List<Pillowpon>> loadDeviceList();

  Future<bool> connectDevice(Pillowpon target);

  StreamSubscription<PillowponMetadata?> loadAndUploadMetadata();

  Future<void> activateAlarm(int type);
}
