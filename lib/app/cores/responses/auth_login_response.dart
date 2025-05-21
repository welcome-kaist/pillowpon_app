import '../models/user.dart';

class AuthLoginResponse {
  User user;
  String token;

  AuthLoginResponse({
    required this.user,
    required this.token,
  });
}
