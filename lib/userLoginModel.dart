import 'dart:convert';

UserLoginModel userLoginModelFromJson(String str) => UserLoginModel.fromJson(json.decode(str));

String userLoginModelToJson(UserLoginModel data) => json.encode(data.toJson());

class UserLoginModel {
  UserLoginModel({
    this.expiry,
    this.token,
    this.user,
  });

  dynamic expiry;
  String token;
  User user;

  factory UserLoginModel.fromJson(Map<String, dynamic> json) => UserLoginModel(
    expiry: json["expiry"],
    token: json["token"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "expiry": expiry,
    "token": token,
    "user": user.toJson(),
  };
}

class User {
  User({
    this.id,
    this.phone,
    this.name,
    this.email,
    this.gender,
    this.userType,
    this.licenceNo,
  });

  int id;
  String phone;
  String name;
  dynamic email;
  String gender;
  String userType;
  dynamic licenceNo;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    phone: json["phone"],
    name: json["name"],
    email: json["email"],
    gender: json["gender"],
    userType: json["user_type"],
    licenceNo: json["licence_no"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "phone": phone,
    "name": name,
    "email": email,
    "gender": gender,
    "user_type": userType,
    "licence_no": licenceNo,
  };
}