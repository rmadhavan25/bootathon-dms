import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.detail,
  });

  String detail;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    detail: json["detail"],
  );

  Map<String, dynamic> toJson() => {
    "detail": detail,
  };
}