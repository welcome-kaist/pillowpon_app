import 'dart:async';

import 'package:myapp/app/cores/models/pillowpon_metadata.dart';
import 'package:myapp/app/cores/models/sleep_score.dart';
import 'package:myapp/app/cores/models/user.dart';
import 'package:myapp/app/cores/services/data_service.dart';

class SupabaseDataService extends DataService{
  @override
  StreamSubscription<SleepScore> sleepScoreUpdateStream(User user) {
    // TODO: implement sleepScoreUpdateStream
    throw UnimplementedError();
  }
  void subscribeSleepScore(){}

  @override
  void uploadMetadata(User owner, String metadata) {
    // TODO: implement uploadMetadata
  }

  @override
  // TODO: implement sleepScoreList
  List<SleepScore> get sleepScoreList => throw UnimplementedError();

}