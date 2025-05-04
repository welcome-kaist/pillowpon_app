import 'dart:async';

import 'package:get/get.dart';
import 'package:myapp/app/cores/models/pillowpon.dart';
import 'package:myapp/app/cores/models/pillowpon_metadata.dart';

abstract class DeviceService extends GetxService {
  List<Pillowpon> get deviceList;

  Pillowpon? get connected_device;

  StreamSubscription<List<Pillowpon>> loadDeviceList();

  Future<bool> connectDevice(Pillowpon target);

  Stream<PillowponMetadata> metadataStream();
}
