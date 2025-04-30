import 'package:get/get.dart';
import 'package:myapp/app/cores/services/auth_service.dart';
import 'package:myapp/app/cores/services/supabase_auth_service.dart';

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    // LocalSourceBindings().dependencies();
    // RepositoryBindings().dependencies();
    Get.put<AuthService>(SupabaseAuthService());
  }
}
