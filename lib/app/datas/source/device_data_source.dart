import 'dart:async';

import 'package:myapp/app/cores/models/pillowpon.dart';

import '../../cores/models/pillowpon_metadata.dart';

abstract class DeviceDataSource {
  Stream<List<Pillowpon>> loadDeviceList();

  Future<bool> connectDevice(String deviceId);

  Stream<PillowponMetadata?> metadataStream();

  Future<void> disconnectDevice();

  Future<void> activateAlarm(int type);
}
