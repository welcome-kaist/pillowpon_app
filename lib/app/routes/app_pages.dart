import 'package:get/get.dart';

import '../modules/login/bindings/login_bindings.dart';
import '../modules/login/views/login_view.dart';
import '../modules/logout/bindings/logout_bindings.dart';
import '../modules/logout/views/logout_view.dart';
import '../modules/main/bindings/main_bindings.dart';
import '../modules/main/views/main_view.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.LOGOUT;

  static final List<GetPage> routes = [
    GetPage(
      name: Routes.MAIN,
      page: () => MainView(),
      binding: MainBindings(),
    ),
    GetPage(
      name: Routes.LOGOUT,
      page: () => LogoutView(),
      binding: LogoutBindings(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginView(),
      binding: LoginBindings(),
    )
  ];
}
