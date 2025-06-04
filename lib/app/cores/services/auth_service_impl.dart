import 'package:get/get.dart';
import 'package:myapp/app/cores/models/user.dart';
import 'package:myapp/app/cores/responses/auth_login_response.dart';
import 'package:myapp/app/cores/responses/auth_register_response.dart';
import 'package:myapp/app/cores/services/auth_service.dart';

import '../../datas/source/auth_data_source.dart';
import '../../routes/app_pages.dart';

class AuthServiceImpl extends AuthService {
  final _source = Get.find<AuthDataSource>(tag: (AuthDataSource).toString());

  final Rx<User?> _rxUser = Rx(null);

  final RxString _rxAccessToken = RxString('');

  @override
  String get accessToken => _rxAccessToken.value;

  @override
  User? get user => _rxUser.value;

  @override
  Future<bool> autoLogin() async {
    throw UnimplementedError();
  }

  @override
  Future<String?> login(
      {required String email, required String password}) async {
    AuthLoginResponse? response =
        await _source.login(email: email, password: password);
    if (response == null) {
      return null;
    }
    _rxUser(response.user);
    storeAuthToken(response.token);
    return response.token;
  }

  @override
  Future<void> logout() {
    removeAuthToken();
    Get.offAllNamed(Routes.LOGOUT);
    return _source.logout();
  }

  @override
  Future<String?> register(
      {required String name,
      required String email,
      required String password,
      required int age,
      required String gender}) async {
    AuthRegisterResponse? response = await _source.register(
      name: name,
      email: email,
      password: password,
      age: age,
      gender: gender,
    );
    if (response == null) {
      return null;
    }
    _rxUser(response.user);
    storeAuthToken(response.token);
    return response.token;
  }

  void storeAuthToken(String token) {
    _rxAccessToken(token);
  }

  void removeAuthToken() {}
}
