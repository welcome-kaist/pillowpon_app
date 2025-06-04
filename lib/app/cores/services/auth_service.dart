import 'package:get/get.dart';

import '../models/user.dart';

abstract class AuthService extends GetxService {
  User? get user;
  String get accessToken;

  Future<bool> autoLogin();

  Future<String?> login({required String email, required String password});

  Future<String?> register(
      {
      required String name,
      required String email,
      required String password,
      required int age,
      required String gender});

  void logout();
}
