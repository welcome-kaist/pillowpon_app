import 'package:get/get.dart';
import 'package:myapp/app/cores/models/pillowpon.dart';
import 'package:myapp/app/cores/models/pillowpon_metadata.dart';

abstract class DeviceService extends GetxService {
  Pillowpon get connected_device;

  void loadDeviceList();
  void connectDevice(Pillowpon target);
  Stream<PillowponMetadata> metadataStream();
}