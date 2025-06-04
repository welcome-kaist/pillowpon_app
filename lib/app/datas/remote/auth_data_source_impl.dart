import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:myapp/app/cores/requests/auth_register_request.dart';
import 'package:myapp/app/cores/responses/auth_login_response.dart';

import 'package:myapp/app/cores/responses/auth_register_response.dart';

import '../../cores/requests/auth_login_request.dart';
import '../source/auth_data_source.dart';

class AuthDataSourceImpl extends AuthDataSource {
  final String baseUrl =
      "ec2-54-252-175-125.ap-southeast-2.compute.amazonaws.com:3000";

  Logger log = Get.find<Logger>();

  @override
  Future<AuthLoginResponse?> login(
      {required String email, required String password}) async {
    var url = Uri.http(baseUrl, 'auth/login');
    var response = await http.post(url,
        body: AuthLoginRequest(email: email, password: password).toJson());
    log.i(
        'Response status: ${response.statusCode}\nResponse body: ${response.body}');
    if (response.statusCode != 200 && response.statusCode != 201) {
      Fluttertoast.showToast(
          msg: 'Failed to login user: ${jsonDecode(response.body)['message']}');
      return null;
    }

    return AuthLoginResponse.fromJson(jsonDecode(response.body));
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<AuthRegisterResponse?> register(
      {required String name,
      required String email,
      required String password,
      required int age,
      required String gender}) async {
    var url = Uri.http(baseUrl, 'user/register');
    var response = await http.post(url,
        body: AuthRegisterRequest(
                password: password,
                email: email,
                name: name,
                age: age,
                gender: gender)
            .toJson());
    log.i(
        'Response status: ${response.statusCode}\nResponse body: ${response.body}');
    if (response.statusCode != 200 && response.statusCode != 201) {
      Fluttertoast.showToast(
          msg:
              'Failed to register user: ${jsonDecode(response.body)['message']}');
      return null;
    }

    return AuthRegisterResponse.fromJson(jsonDecode(response.body));
  }
}
