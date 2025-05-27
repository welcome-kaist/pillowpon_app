import 'dart:async';

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:myapp/app/cores/models/sleep_score.dart';
import 'package:myapp/app/cores/models/user.dart';
import 'package:myapp/app/cores/services/data_service.dart';

import '../../datas/source/backend_data_source.dart';

class DataServiceImpl extends DataService {
  // final AuthService authService = Get.find<AuthService>();
  final _source =
      Get.find<BackendDataSource>(tag: (BackendDataSource).toString());

  final RxList<SleepScore> _rxSleepScoreList = RxList<SleepScore>.empty();
  @override
  List<SleepScore> get sleepScoreList => _rxSleepScoreList.value;

  Logger log = Get.find<Logger>();

  @override
  StreamSubscription<SleepScore> sleepScoreUpdateStream(User user) {
    return _source.sleepScoreUpdateStream(user).listen((sleepScore) {
      if(sleepScoreList.length >= 15){
        _rxSleepScoreList.removeAt(0);
      }
      _rxSleepScoreList.add(sleepScore);
      log.i('Received sleep score: ${sleepScore.score}');
    });
  }

  void subscribeSleepScore() {}

  @override
  void uploadMetadata(User owner, String metadata) {}
}
