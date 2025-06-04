import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:myapp/app/cores/models/pillowpon_metadata.dart';
import 'package:myapp/app/cores/models/sleep_depth.dart';
import 'package:myapp/app/cores/models/sleep_score.dart';
import 'package:myapp/app/cores/models/user.dart';
import 'package:myapp/app/cores/utils/json_parser.dart';
import 'package:myapp/app/datas/source/backend_data_source.dart';

class BackendDataSourceImpl extends BackendDataSource {
  final String baseUrl =
      "ec2-54-252-175-125.ap-southeast-2.compute.amazonaws.com:3000";

  Logger log = Get.find<Logger>();

  @override
  Stream<Future<SleepDepth?>> sleepDepthUpdateStream(
      int sessionId, String token, User user) {
    return Stream<Future<SleepDepth?>>.periodic(const Duration(seconds: 5),
        (_) async {
      var url = Uri.http(baseUrl, 'sleep-session/$sessionId/depth');
      var response = await http.get(url,
          headers: {'accept': '*/*', 'Authorization': 'Bearer $token'});
      log.i(
          'Response status: ${response.statusCode}\nResponse body: ${response.body}');
      if (response.statusCode != 200 && response.statusCode != 201) {
        log.e('Failed to fetch sleep depth: ${response.body}');
        return null;
      }
      return SleepDepth.fromJson(jsonDecode(response.body));
    });
  }

  @override
  Future<void> uploadMetadata(int sessionId, PillowponMetadata metadata) async {
    var url = Uri.http(baseUrl, 'sleep-session/$sessionId/metadata');
    var response = await http.post(url, body: {}, headers: {
      'accept': '*/*',
    });
    log.i(
        'Response status: ${response.statusCode}\nResponse body: ${response.body}');
    if (response.statusCode != 200 && response.statusCode != 201) {
      log.e('Failed to upload metadata: ${response.body}');
    }
  }

  @override
  Future<int> newSleepSession(String token) async {
    var url = Uri.http(baseUrl, 'sleep-session');
    var response = await http.post(url,
        body: {}, headers: {'accept': '*/*', 'Authorization': 'Bearer $token'});
    log.i(
        'Response status: ${response.statusCode}\nResponse body: ${response.body}');
    if (response.statusCode != 200 && response.statusCode != 201) {
      log.e('Failed to generate new sleep session: ${response.body}');
      return -1;
    }
    return jsonDecode(response.body)["id"];
  }

  @override
  Future<SleepScore> stopSleepSession(int sessionId, String token) async {
    var url = Uri.http(baseUrl, 'sleep-session/$sessionId');
    var response = await http.patch(url,
        body: {}, headers: {'accept': '*/*', 'Authorization': 'Bearer $token'});
    log.i(
        'Response status: ${response.statusCode}\nResponse body: ${response.body}');
    if (response.statusCode != 200 && response.statusCode != 201) {
      log.e('Failed to stop sleep session: ${response.body}');
      return SleepScore(
        score: -1,
        start_time: DateTime.now(),
        end_time: DateTime.now(),
      );
    }
    return SleepScore.fromJson(jsonDecode(response.body));
  }

  @override
  Future<List<SleepScore>> getSleepScores(String token) async {
    var url = Uri.http(baseUrl, 'sleep-session');
    var response = await http
        .get(url, headers: {'accept': '*/*', 'Authorization': 'Bearer $token'});
    log.i(
        'Response status: ${response.statusCode}\nResponse body: ${response.body}');
    if (response.statusCode != 200 && response.statusCode != 201) {
      log.e('Failed to load completed sleep session: ${response.body}');
      return [];
    }
    List<dynamic> temp = jsonDecode(response.body);
    List<Map<String, dynamic>> jsonList =
        temp.map((e) => e as Map<String, dynamic>).toList();
    List<SleepScore> result = [];
    for (var json in jsonList) {
      if (json['sleep_status'] == 'completed') {
        result.add(SleepScore.fromJson(json));
      }
    }
    return result;
  }
}
