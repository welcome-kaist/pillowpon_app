import 'package:myapp/app/cores/responses/auth_register_response.dart';

import '../../cores/responses/auth_login_response.dart';

abstract class AuthDataSource {
  Future<AuthLoginResponse> login(
      {required String email, required String password});

  Future<AuthRegisterResponse> register(
      {required String name, required String email, required String password});

  Future<void> logout();
}
