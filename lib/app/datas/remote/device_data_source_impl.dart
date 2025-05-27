import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:myapp/app/cores/enums/connected_state.dart';
import 'package:myapp/app/cores/models/pillowpon.dart';
import 'package:myapp/app/cores/models/pillowpon_metadata.dart';
import 'package:path_provider/path_provider.dart';

import '../source/device_data_source.dart';

class DeviceDataSourceImpl extends DeviceDataSource {
  BluetoothAdapterState get _adapterState => _rxAdapterState.value;
  final Rx<BluetoothAdapterState> _rxAdapterState =
      BluetoothAdapterState.unknown.obs;

  late StreamSubscription<BluetoothAdapterState> _adapterStateStateSubscription;
  late StreamSubscription<List<ScanResult>> _scanResultsSubscription;
  late StreamSubscription<bool> _isScanningSubscription;
  late StreamSubscription<BluetoothConnectionState>
      _connectionStateSubscription;
  late StreamSubscription<bool> _isConnectingSubscription;
  late StreamSubscription<bool> _isDisconnectingSubscription;
  late StreamSubscription<int> _mtuSubscription;

  final RxBool _rxIsScanning = RxBool(false);

  bool get _isScanning => _rxIsScanning.value;

  final RxList<ScanResult> _rxScanResults = RxList.empty();

  List<ScanResult> get _scanResults => _rxScanResults.value;

  final Rx<BluetoothConnectionState> _rxConnectionState =
      BluetoothConnectionState.disconnected.obs;

  BluetoothConnectionState get _connectionState => _rxConnectionState.value;

  List<BluetoothDevice> _systemDevices = [];
  BluetoothDevice? _connectedDevice;

  final RxList<BluetoothService> _rxServices = RxList.empty();

  List<BluetoothService> get services => _rxServices.value;

  final Rx<int?> _rxRssi = Rx<int?>(null);

  int? get _rssi => _rxRssi.value;

  final Rx<int?> _rxMtuSize = Rx<int?>(null);

  int? get _mtuSize => _rxMtuSize.value;

  final Rx<BluetoothCharacteristic?> _rxCharacteristic =
      Rx<BluetoothCharacteristic?>(null);

  BluetoothCharacteristic? get characteristic => _rxCharacteristic.value;

  Logger log = Get.find<Logger>();

  @override
  void onInit() {
    _adapterStateStateSubscription =
        FlutterBluePlus.adapterState.listen((state) {
      _rxAdapterState(state);
    });

    _scanResultsSubscription = FlutterBluePlus.scanResults.listen((results) {
      _rxScanResults(results);
    }, onError: (e) {
      log.e(
        "Scan Error:$e",
      );
    });

    _isScanningSubscription = FlutterBluePlus.isScanning.listen((state) {
      _rxIsScanning(state);
    });
  }

  @override
  void onClose() {
    _adapterStateStateSubscription.cancel();
    _scanResultsSubscription.cancel();
    _isScanningSubscription.cancel();
  }

  @override
  Future<bool> connectDevice(String deviceId) async {
    bool isConnected = false;
    for (var result in FlutterBluePlus.lastScanResults) {
      if (result.device.remoteId.toString() == deviceId) {
        return connect(result.device).then((_) {
          initiateConnectState(result.device);
          return true;
        }).catchError((e) {
          log.e("Connect Error: $e");
          return false;
        });
      }
    }
    return false;
  }

  @override
  Stream<List<Pillowpon>> loadDeviceList() {
    scan();
    return FlutterBluePlus.scanResults.map((results) {
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
    return characteristic!.lastValueStream.map((value) {
      return PillowponMetadata.fromJson(jsonDecode(utf8.decode(value)));
    });
  }

  Future<void> connect(BluetoothDevice device) async {
    device.connect().then((_) {
      log.i("Connected to ${device.name}");
      _connectedDevice = device;
      mtu(device);
      saveDeviceId(device.remoteId.toString());
    }).catchError((error) {
      log.e("Failed to connect to ${device.name}: $error");
    });
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/remoteId.txt');
  }

  void saveDeviceId(String deviceId) async {
    final file = await _localFile;
    await file.writeAsString(deviceId);
  }

  void autoConnect() async {
    final file = await _localFile;
    final String remoteId = await file.readAsString();
    var device = BluetoothDevice.fromId(remoteId);

    connect(device);

    await device.connectionState
        .where((val) => val == BluetoothConnectionState.connected)
        .first;
  }

  void mtu(BluetoothDevice device) async {
    final subscription = device.mtu.listen((int mtu) {
      // iOS: initial value is always 23, but iOS will quickly negotiate a higher value
      print("mtu $mtu");
    });

// cleanup: cancel subscription when disconnected
    device.cancelWhenDisconnected(subscription);

// You can also manually change the mtu yourself.
    if (!kIsWeb && Platform.isAndroid) {
      await device.requestMtu(512);
    }
  }

  void read(BluetoothService service) async {
    var characteristics = service.characteristics;
    //TODO : do for all characteristics
    for (var c in characteristics) {
      if (c.properties.read) {
        List<int> value = await c.read();
        log.i("characteristic : $value");
      }
    }
  }

  void initiateConnectState(BluetoothDevice device) {
    _connectionStateSubscription = device.connectionState.listen((state) async {
      _rxConnectionState(state);
      if (state == BluetoothConnectionState.connected) {
        discoveryServices(device);
      }
      if (state == BluetoothConnectionState.connected && _rssi == null) {
        _rxRssi(await device.readRssi());
      }
    });

    _mtuSubscription = device.mtu.listen((value) {
      _rxMtuSize(value);
    });
  }

  void discoveryServices(BluetoothDevice device) async {
    _rxServices(await device.discoverServices());
    log.i("Services discovered: ${_rxServices.length}");
    for(var service in services) {
      log.i("Service: ${service.uuid}");
      read(service);
    }
  }
}
