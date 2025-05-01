import 'dart:async';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:myapp/app/cores/models/pillowpon.dart';
import 'package:myapp/app/cores/models/pillowpon_metadata.dart';
import 'package:myapp/app/cores/services/device_service.dart';
import 'package:myapp/app/datas/source/device_data_source.dart';

class DeviceServiceImpl extends DeviceService {
  final _source =
      Get.find<DeviceDataSource>(tag: (DeviceDataSource).toString());

  final Rx<List<Pillowpon>> _rxDeviceList = Rx<List<Pillowpon>>([]);

  List<Pillowpon> get deviceList => _rxDeviceList.value;

  @override
  Pillowpon? get connected_device => null;

  @override
  Future<Pillowpon> connectDevice(Pillowpon target) {
    return _source.connectDevice(target.id).then((target) {
      connected_device = target;
      return target;
    });
  }

  set connected_device(Pillowpon? device) {
    connected_device = device;
  }

  @override
  StreamSubscription<List<Pillowpon>> loadDeviceList() {
    return _source.loadDeviceList().listen((devices) {
      devices.sort((a, b) {
        return a.name.compareTo(b.name);
      });
      _rxDeviceList(devices);
    });
  }

  @override
  Stream<PillowponMetadata> metadataStream() {
    // TODO: implement metadataStream
    throw UnimplementedError();
  }
}
