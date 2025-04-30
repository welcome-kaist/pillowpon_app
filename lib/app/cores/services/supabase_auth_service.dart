import 'package:myapp/app/cores/models/user.dart';

import 'auth_service.dart';

class SupabaseAuthService extends AuthService {
  @override
  Future<bool> autoLogin() {
    // TODO: implement autoLogin
    throw UnimplementedError();
  }

  @override
  // TODO: implement user
  User get user => throw UnimplementedError();

  @override
  Future<String?> login({required String email, required String password}) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  void logout() {
    // TODO: implement logout
  }

  @override
  Future<String?> register(
      {required String name, required String email, required String password}) {
    // TODO: implement register
    throw UnimplementedError();
  }

  void storeAuthToken() {}
  void removeAuthToken() {}
}
