import 'dart:math';

import 'package:myapp/app/cores/enums/connected_state.dart';
import 'package:myapp/app/cores/models/pillowpon.dart';
import 'package:myapp/app/cores/models/pillowpon_metadata.dart';
import 'package:myapp/app/datas/source/device_data_source.dart';

class DeviceDummy extends DeviceDataSource {
  @override
  Stream<List<Pillowpon>> loadDeviceList() {
    return Stream.value([
      Pillowpon(
        id: "dummy_id_1",
        name: "Dummy Device 1",
        connectedState: ConnectedState.NONE,
      ),
      Pillowpon(
        id: "dummy_id_2",
        name: "Dummy Device 2",
        connectedState: ConnectedState.NONE,
      ),
    ]);
  }

  @override
  Future<bool> connectDevice(String deviceId) {
    // Simulate a successful connection
    return Future.delayed(Duration(seconds: 1), () {
      return true;
    });
  }

  @override
  Stream<PillowponMetadata> metadataStream() {
    return Stream.periodic(
      const Duration(seconds: 1),
      (count) => PillowponMetadata(
        pressure: Random().nextDouble() * 100 + 100,
        accelerator: Random().nextDouble() + 1,
        humidity: Random().nextDouble() * 10 + 50,
        temperature: Random().nextDouble() * 5 + 25,
        body_detection: Random().nextDouble() > 0.5 ? 1 : 0,
        photoresistor: Random().nextDouble() * 100 + 300,
        sound: Random().nextDouble() * 10 + 20,
        time: count * 1000,
      ),
    ).takeWhile(
      (metadata) => metadata.time < 60000,
    );
  }
}
