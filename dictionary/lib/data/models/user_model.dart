class UserModel {
  final int id;
  final String name;
  final String email;

  UserModel({required this.id, required this.name, required this.email});

  factory UserModel.fromMap(Map<String, dynamic> json) =>
      UserModel(id: json['user_id'], name: json['name'], email: json['email']);

  Map<String, dynamic> toMap() => {'user_id': id, 'name': name, 'email': email};
}
