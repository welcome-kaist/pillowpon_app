import '../models/user.dart';

class AuthRegisterResponse {
  User user;
  String token;

  AuthRegisterResponse({
    required this.user,
    required this.token,
  });
}
