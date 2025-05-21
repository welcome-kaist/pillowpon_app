import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/modules/login/models/login_validator.dart';

import '../../../cores/services/auth_service.dart';
import '../../../cores/utils/error_snackbar.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController{
  final LoginValidator validator = LoginValidator();

  final RxString _rxUserName = RxString("");

  String get userName => _rxUserName.value;

  final RxString _rxUserEmail = RxString("");

  String get userEmail => _rxUserEmail.value;

  final RxString _rxUserPassword = RxString("");

  String get userPassword => _rxUserPassword.value;

  final RxBool _rxIsLoginValid = RxBool(true);

  bool get isLoginValid => _rxIsLoginValid.value;

  final RxBool _rxIsLoading = RxBool(false);

  bool get isLoading => _rxIsLoading.value;

  AuthService get authService => Get.find<AuthService>();

  set userName(String value) {
    _rxUserName.value = value;
  }

  set userEmail(String value) {
    _rxUserEmail.value = value;
  }

  set userPassword(String value) {
    _rxUserPassword.value = value;
  }

  VoidCallback login(GlobalKey<FormState> formKey) {
    return () async {
      _rxIsLoginValid(validator.tryValidation(formKey));
      if (!_rxIsLoginValid.value) {
        _rxIsLoading(false);
        return;
      }
      try {
       final token = await authService.login(
          email: userEmail,
          password: userPassword,
        );
        final user = authService.user;
        if (user != null) {
          _rxIsLoading(false);
          Get.offAndToNamed(Routes.MAIN);
        }
      } catch (e) {
        ErrorSnackbar.show(e.toString());
        _rxIsLoading(false);
      }
    };
  }

  VoidCallback back(){
    return () {
      Get.back();
    };
  }
}