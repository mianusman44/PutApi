import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

class UserModel {
  UserModel({
    this.name,
    this.job,
    this.updatedAt,
  });

  String name;
  String job;
  DateTime updatedAt;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json["name"],
        job: json["job"],
        updatedAt: DateTime.parse(json["updatedAt"]),
      );
}
