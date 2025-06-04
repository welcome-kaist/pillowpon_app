import '../models/user.dart';

class AuthRegisterResponse {
  User user;
  String token;

  AuthRegisterResponse({
    required this.user,
    required this.token,
  });

  AuthRegisterResponse.fromJson(Map<String, dynamic> json)
      : user = User.fromJson(json['user']),
        token = json['accessToken'];
}
