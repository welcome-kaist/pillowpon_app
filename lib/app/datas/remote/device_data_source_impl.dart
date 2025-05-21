import 'dart:async';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:myapp/app/cores/enums/connected_state.dart';
import 'package:myapp/app/cores/models/pillowpon.dart';
import 'package:myapp/app/cores/models/pillowpon_metadata.dart';

import '../source/device_data_source.dart';

class DeviceDataSourceImpl extends DeviceDataSource {
  List<BluetoothDevice> _systemDevices = [];
  List<ScanResult> _scanResults = [];

  Logger log = Get.find<Logger>();

  @override
  Future<bool> connectDevice(String deviceId) {
    bool isConnected = false;
    for (var result in _scanResults) {
      if (result.device.remoteId.toString() == deviceId) {
          result.device.connect().then((_) {
          isConnected = true;
          log.i("Connected to $deviceId");
        }).catchError((error) {
          log.e("Failed to connect to $deviceId: $error");
        });
      }
    }
    return Future.value(isConnected);
  }

  @override
  Stream<List<Pillowpon>> loadDeviceList() {
    scan();
    return FlutterBluePlus.scanResults.map((results) {
      _scanResults = results;
      return results
          .map((result) => Pillowpon(
                id: result.device.remoteId.toString(),
                name: result.advertisementData.advName == ""
                    ? "unknown: ${result.device.remoteId}"
                    : result.advertisementData.advName,
                connectedState: ConnectedState.NONE,
              ))
          .toList();
    });
  }

  Future scan() async {
    try {
      // `withServices` is required on iOS for privacy purposes, ignored on android.
      var withServices = [Guid("180f")]; // Battery Level Service
      _systemDevices = await FlutterBluePlus.systemDevices(withServices);
    } catch (e, backtrace) {
      log.e("System Devices Error: $e");
      log.e("backtrace: $backtrace");
    }
    try {
      await FlutterBluePlus.startScan(
        timeout: const Duration(seconds: 15),
        webOptionalServices: [
          Guid("180f"), // battery
          Guid("1800"), // generic access
          Guid("6e400001-b5a3-f393-e0a9-e50e24dcca9e"), // Nordic UART
        ],
      );
    } catch (e, backtrace) {
      log.e("Start Scan Error: $e");
      log.e("backtrace: $backtrace");
    }
  }

  @override
  Stream<PillowponMetadata> metadataStream() {
    // TODO: implement metadataStream
    throw UnimplementedError();
  }
}
