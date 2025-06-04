class User {
  String id;
  String name;
  String email;
  int age;
  String gender;

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.age,
      required this.gender});

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        email = json['email'],
        age = json['age'].runtimeType == int ? json['age'] : int.parse(json['age']),
        gender = json['gender'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'age': age,
      'gender': gender,
    };
  }
}
