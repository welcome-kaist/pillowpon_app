import 'dart:async';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:myapp/app/cores/models/pillowpon.dart';
import 'package:myapp/app/cores/models/pillowpon_metadata.dart';
import 'package:myapp/app/cores/services/device_service.dart';
import 'package:myapp/app/datas/source/device_data_source.dart';

import '../enums/connected_state.dart';

class DeviceServiceImpl extends DeviceService {
  final _source =
      Get.find<DeviceDataSource>(tag: (DeviceDataSource).toString());

  final Rx<List<Pillowpon>> _rxDeviceList = Rx<List<Pillowpon>>([]);

  List<Pillowpon> get deviceList => _rxDeviceList.value;

  final Rx<Pillowpon?> _rxConnectedDevice = Rx<Pillowpon?>(null);

  @override
  Pillowpon? get connected_device => _rxConnectedDevice.value;

  @override
  Future<bool> connectDevice(Pillowpon target) {
    return _source.connectDevice(target.id).then((_) {
      _rxConnectedDevice(target);
      if (_) {
        connected_device!.connectedState = ConnectedState.SUCCESS;
      } else {
        connected_device!.connectedState = ConnectedState.FAILURE;
      }
      return _;
    });
  }

  @override
  StreamSubscription<List<Pillowpon>> loadDeviceList() {
    return _source.loadDeviceList().listen((devices) {
      devices.sort((a, b) {
        if(a.name.contains("unknown")) {
          return 1;
        } else if(b.name.contains("unknown")) {
          return -1;
        }
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
