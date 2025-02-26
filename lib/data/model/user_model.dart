import 'package:flutter_chat_app/domain/entity/user.dart';

class UserModel {
  final String id;
  final String email;
  final String name;
  final int age;
  final String gender;
  final bool isReceptionAllowed;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.age,
    required this.gender,
    required this.isReceptionAllowed,
  });

  factory UserModel.fromJson(String id, Map<String, dynamic> json) {
    return UserModel(
      id: id,
      email: json['email'],
      name: json['name'],
      age: json['age'],
      gender: json['gender'],
      isReceptionAllowed: json['isReceptionAllowed'],
    );
  }

  User toEntity() {
    return User(
      id: id,
      email: email,
      name: name,
      age: age,
      gender: Gender.fromLabel(gender),
      isReceptionAllowed: isReceptionAllowed,
    );
  }
}
