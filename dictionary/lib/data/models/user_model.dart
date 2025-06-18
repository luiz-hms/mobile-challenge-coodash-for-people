class UserModel {
  final int id;
  final String name;
  final String email;
  final String password;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
  });

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
    id: json['user_id'],
    name: json['name'],
    email: json['email'],
    password: json['password'],
  );

  Map<String, dynamic> toMap() => {
    'user_id': id,
    'name': name,
    'email': email,
    'password': password,
  };
}
