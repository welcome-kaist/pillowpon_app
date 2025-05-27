import 'dart:convert';
import 'dart:typed_data';

import 'package:bluetooth_classic/bluetooth_classic.dart';
import 'package:bluetooth_classic/models/device.dart';
import 'package:get/get.dart';
import 'package:myapp/app/cores/models/pillowpon.dart';
import 'package:myapp/app/cores/models/pillowpon_metadata.dart';
import 'package:myapp/app/datas/source/device_data_source.dart';

import '../../cores/enums/connected_state.dart';

class DeviceDataSourceSerial extends DeviceDataSource {
  final RxList<Device> _rxScanDevices = RxList<Device>.empty();

  List<Device> get scanDevices => _rxScanDevices.value;
  final _bluetoothClassicPlugin = BluetoothClassic();

  DeviceDataSourceSerial() {
    _bluetoothClassicPlugin.initPermissions();
  }

  @override
  Future<bool> connectDevice(String deviceId) {
    return _bluetoothClassicPlugin
        .connect(deviceId, "00001101-0000-1000-8000-00805F9B34FB")
        .then((value) {
      _bluetoothClassicPlugin.stopScan();
      return true;
    }).catchError((error) {
      _bluetoothClassicPlugin.stopScan();
      return false;
    });
  }

  @override
  Stream<List<Pillowpon>> loadDeviceList() {
    _bluetoothClassicPlugin.startScan();
    return _bluetoothClassicPlugin.onDeviceDiscovered().map((result) {
      for (var device in scanDevices) {
        if (device.address == result.address) {
          return scanDevices
              .map((device) => Pillowpon(
                    id: device.address,
                    name: device.name ?? "Unknown Device",
                    connectedState: ConnectedState.NONE,
                  ))
              .toList();
        }
      }

      _rxScanDevices.add(result);
      return _rxScanDevices
          .map((device) => Pillowpon(
                id: device.address,
                name: device.name ?? "Unknown Device",
                connectedState: ConnectedState.NONE,
              ))
          .toList();
    });
  }

  @override
  Stream<PillowponMetadata> metadataStream() {
    return _bluetoothClassicPlugin.onDeviceDataReceived().map((data) {
      // Assuming data is in JSON format
      final jsonString = String.fromCharCodes(data);
      final jsonData = PillowponMetadata.fromJson(jsonDecode(jsonString));
      return jsonData;
    });
  }
}
