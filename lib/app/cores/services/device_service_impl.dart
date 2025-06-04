import 'dart:async';

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:myapp/app/cores/models/pillowpon.dart';
import 'package:myapp/app/cores/models/pillowpon_metadata.dart';
import 'package:myapp/app/cores/services/data_service.dart';
import 'package:myapp/app/cores/services/device_service.dart';
import 'package:myapp/app/datas/source/device_data_source.dart';

import '../enums/connected_state.dart';

class DeviceServiceImpl extends DeviceService {
  final _source =
      Get.find<DeviceDataSource>(tag: (DeviceDataSource).toString());

  final Rx<List<Pillowpon>> _rxDeviceList = Rx<List<Pillowpon>>([]);

  @override
  List<Pillowpon> get deviceList => _rxDeviceList.value;

  final Rx<Pillowpon?> _rxConnectedDevice = Rx<Pillowpon?>(null);

  final RxList<PillowponMetadata> _rxMetadataList =
      RxList<PillowponMetadata>.empty();

  List<PillowponMetadata> get metadataList => _rxMetadataList.value;

  Logger log = Get.find<Logger>();

  DataService get backendService => Get.find<DataService>();

  @override
  Pillowpon? get connectedDevice => _rxConnectedDevice.value;

  @override
  Future<bool> connectDevice(Pillowpon target) {
    return _source.connectDevice(target.id).then((_) {
      _rxConnectedDevice(target);
      if (_) {
        connectedDevice!.connectedState = ConnectedState.SUCCESS;
      } else {
        connectedDevice!.connectedState = ConnectedState.FAILURE;
      }
      return _;
    });
  }

  @override
  StreamSubscription<List<Pillowpon>> loadDeviceList() {
    return _source.loadDeviceList().listen((devices) {
      devices.sort((a, b) {
        if (a.name.contains("unknown")) {
          return 1;
        } else if (b.name.contains("unknown")) {
          return -1;
        }
        return a.name.compareTo(b.name);
      });
      _rxDeviceList(devices);
    });
  }

  @override
  StreamSubscription<PillowponMetadata?> loadAndUploadMetadata() {
    return _source.metadataStream().listen((metadata) {
      if (metadata == null) {
        log.w("Received null metadata, skipping.");
        return;
      }
      backendService.uploadMetadata(metadata);
      _rxMetadataList.add(metadata);
      log.i("Metadata received: ${metadata.toJson()}");
    });
  }

  @override
  void onClose() {
    _source.disconnectDevice();
  }

  @override
  Future<void> activateAlarm(int type) {
    return _source.activateAlarm(type).then((_) {
      log.i("Alarm activated with type: $type");
    }).catchError((error) {
      log.e("Failed to activate alarm: $error");
    });
  }
}
