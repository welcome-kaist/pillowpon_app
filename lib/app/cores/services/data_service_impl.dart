import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:myapp/app/cores/models/pillowpon_metadata.dart';
import 'package:myapp/app/cores/models/sleep_depth.dart';
import 'package:myapp/app/cores/models/sleep_score.dart';
import 'package:myapp/app/cores/models/user.dart';
import 'package:myapp/app/cores/services/auth_service.dart';
import 'package:myapp/app/cores/services/data_service.dart';

import '../../datas/source/backend_data_source.dart';

class DataServiceImpl extends DataService {
  // final AuthService authService = Get.find<AuthService>();
  final _source =
      Get.find<BackendDataSource>(tag: (BackendDataSource).toString());

  Logger log = Get.find<Logger>();

  AuthService get authService => Get.find<AuthService>();

  final RxInt _rxSleepSessionId = RxInt(-1);

  int get sleepSessionId => _rxSleepSessionId.value;

  final RxList<SleepDepth> _rxSleepDepthList = RxList<SleepDepth>.empty();

  @override
  List<SleepDepth> get sleepDepthList => _rxSleepDepthList.value;

  @override
  StreamSubscription<Future<SleepDepth?>> sleepDepthUpdateStream() {
    return _source
        .sleepDepthUpdateStream(
            sleepSessionId, authService.accessToken, authService.user!)
        .listen((sleepDepth) {
      sleepDepth.then((value) {
        if (value == null) {
          log.e('Received null sleep depth. Skipping update.');
          return;
        }
        if (sleepDepthList.length >= 15) {
          _rxSleepDepthList.removeAt(0);
        }
        _rxSleepDepthList.add(value);
        log.i('Received sleep depth: ${value.depth}');
      });
    });
  }

  @override
  void uploadMetadata(PillowponMetadata metadata) {
    if (authService.user == null) {
      log.e('User is not authenticated. Cannot upload metadata.');
      return;
    }
    return _source.uploadMetadata(sleepSessionId, metadata);
  }

  @override
  Future<void> newSleepSession() async {
    if (authService.accessToken.isEmpty) {
      log.e('Access token is empty. Cannot create new sleep session.');
      return;
    }
    _rxSleepDepthList.clear();
    _rxSleepSessionId(await _source.newSleepSession(authService.accessToken));
  }

  @override
  Future<SleepScore> stopSleepSession() {
    return _source.stopSleepSession(sleepSessionId, authService.accessToken);
  }

  @override
  Future<Map<int, SleepScore>> getMonthlySleepScores() {
    return _source
        .getSleepScores(authService.accessToken)
        .then((scores) {
      DateTime now = DateTime.now();
      int daysInMonth = DateUtils.getDaysInMonth(now.year, now.month);

      Map<int, SleepScore> monthlyScores = {};
      for (SleepScore score in scores) {
        if (now.year == score.end_time.year &&
            now.month == score.end_time.month) {
          if(!monthlyScores.containsKey(score.end_time.day)) {
            monthlyScores[score.end_time.day] = score;
          }
          else if (monthlyScores.containsKey(score.end_time.day) &&
              monthlyScores[score.end_time.day]!.score < score.score) {
            // Update the score for the day if it's higher than the current one
            monthlyScores[score.end_time.day] = score;
          }
        }
      }
      return monthlyScores;
    });
  }
}
