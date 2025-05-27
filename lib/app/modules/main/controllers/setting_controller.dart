import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:myapp/app/cores/services/auth_service.dart';

class SettingController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController transitionController;
  late final Rx<Animation<Offset>> _rxTransitionAnimation;
  Animation<Offset> get transitionAnimation => _rxTransitionAnimation.value;

  AuthService get authService => Get.find<AuthService>();
  @override
  void onInit() {
    super.onInit();
    transitionController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _rxTransitionAnimation =
        Tween<Offset>(begin: Offset.zero, end: const Offset(1.5, 0.0)).animate(
      CurvedAnimation(parent: transitionController, curve: Curves.easeInOut),
    ).obs;
  }

  @override
  void onClose() {
    transitionController.dispose();
    super.onClose();
  }
}
