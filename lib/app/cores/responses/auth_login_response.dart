import '../models/user.dart';

class AuthLoginResponse {
  User user;
  String token;

  AuthLoginResponse({
    required this.user,
    required this.token,
  });

  AuthLoginResponse.fromJson(Map<String, dynamic> json)
      : user = User.fromJson(json['user']),
        token = json['accessToken'];
}
