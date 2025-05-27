import 'dart:math';

import 'package:myapp/app/cores/models/sleep_score.dart';
import 'package:myapp/app/cores/models/user.dart';
import 'package:myapp/app/datas/source/backend_data_source.dart';

class BackendDummy extends BackendDataSource {
  @override
  Stream<SleepScore> sleepScoreUpdateStream(User user) {
    return Stream<SleepScore>.periodic(
      const Duration(seconds: 10),
      (count) => SleepScore(
        score: Random().nextInt(101),
        start_time: DateTime(0, 0, 0, 0, 0, count * 10),
        end_time: DateTime(0, 0, 0, 0, 15, count * 10),
      ),
    );
  }

  @override
  void uploadMetadata(User owner, String metadata) {}
}
