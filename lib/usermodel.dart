import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.status,
    this.detail,
  });

  int status;
  String detail;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    status: json["status"],
    detail: json["detail"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "detail": detail,
  };
}