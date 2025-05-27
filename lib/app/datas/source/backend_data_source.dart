import '../../cores/models/sleep_score.dart';
import '../../cores/models/user.dart';

abstract class BackendDataSource {
  Stream<SleepScore> sleepScoreUpdateStream(User user);
  void uploadMetadata(User owner, String metadata);
}