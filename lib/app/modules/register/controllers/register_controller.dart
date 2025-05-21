import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../cores/services/auth_service.dart';
import '../../../cores/utils/error_snackbar.dart';
import '../../../routes/app_pages.dart';
import '../models/register_validator.dart';

class RegisterController extends GetxController {
  final RegisterValidator validator = RegisterValidator();

  final RxString _rxUserName = RxString("");

  String get userName => _rxUserName.value;

  final RxString _rxUserEmail = RxString("");

  String get userEmail => _rxUserEmail.value;

  final RxString _rxUserPassword = RxString("");

  String get userPassword => _rxUserPassword.value;

  final RxBool _rxIsRegisterValid = RxBool(true);

  bool get isRegisterValid => _rxIsRegisterValid.value;

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

  VoidCallback register(GlobalKey<FormState> formKey) {
    return () async {
      _rxIsLoading(true);
      _rxIsRegisterValid(validator.tryValidation(formKey));
      if (!_rxIsRegisterValid.value) {
        _rxIsLoading(false);
        return;
      }
      try {
        final token = await authService.register(
            name: userName, email: userEmail, password: userPassword);
        final newUser = authService.user;
        if (newUser != null) {
          _rxIsLoading(false);
          Get.offAndToNamed(Routes.MAIN);
        }
      } catch (e) {
        _rxIsLoading(false);
        ErrorSnackbar.show(e.toString());
      }
    };
  }

  VoidCallback back() {
    return () {
      Get.back();
    };
  }
}
