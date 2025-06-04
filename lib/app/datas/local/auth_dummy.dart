import 'package:myapp/app/cores/models/user.dart';
import 'package:myapp/app/cores/responses/auth_register_response.dart';
import 'package:myapp/app/datas/source/auth_data_source.dart';

import '../../cores/responses/auth_login_response.dart';

class AuthDummy implements AuthDataSource {
  @override
  Future<AuthLoginResponse> login(
      {required String email, required String password}) {
    return Future(() => AuthLoginResponse(
          token: "dummy_token",
          user: User(
              id: "1",
              name: "Dummy User",
              email: email,
              age: 20,
              gender: "male"),
        ));
  }

  @override
  Future<void> logout() {
    return Future(() => null);
  }

  @override
  Future<AuthRegisterResponse> register(
      {required String name,
      required String email,
      required String password,
      required int age,
      required String gender}) {
    return Future(() => AuthRegisterResponse(
          user:
              User(id: "1", name: name, email: email, age: 20, gender: "male"),
          token: "dummy_token",
        ));
  }
}
