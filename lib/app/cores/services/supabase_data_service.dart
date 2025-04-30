import 'package:myapp/app/cores/models/pillowpon_metadata.dart';
import 'package:myapp/app/cores/models/sleep_score.dart';
import 'package:myapp/app/cores/models/user.dart';
import 'package:myapp/app/cores/services/data_service.dart';

class SupabaseDataService extends DataService{
  @override
  SleepScore sleepScoreUpdateStream(User user) {
    // TODO: implement sleepScoreUpdateStream
    throw UnimplementedError();
  }

  @override
  void uploadMetadata(User owner, PillowponMetadata metadata) {
    // TODO: implement uploadMetadata
  }

  void subscribeSleepScore(){}

}