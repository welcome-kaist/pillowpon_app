class AuthRegisterRequest {
  String password;
  String email;
  String name;
  int age;
  String gender;

  AuthRegisterRequest(
      {
      required this.password,
      required this.email,
      required this.name,
      required this.age,
      required this.gender});

  Map<String, dynamic> toJson() {
    return {
      'password': password,
      'email': email,
      'name': name,
      'age': age.toString(),
      'gender': gender,
    };
  }
}
