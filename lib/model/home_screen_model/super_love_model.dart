// To parse this JSON data, do
//
//     final superLoveModel = superLoveModelFromJson(jsonString);

import 'dart:convert';

SuperLoveModel superLoveModelFromJson(String str) =>
    SuperLoveModel.fromJson(json.decode(str));

String superLoveModelToJson(SuperLoveModel data) => json.encode(data.toJson());

class SuperLoveModel {
  SuperLoveModel({
    required this.response,
    required this.msg,
    required this.token,
    required this.statusCode,
    required this.isMatch,
  });

  String response;
  String msg;
  bool isMatch;
  String token;
  int statusCode;

  factory SuperLoveModel.fromJson(Map<String, dynamic> json) => SuperLoveModel(
        response: json["response"] ?? "",
        msg: json["msg"] ?? "",
        token: json["token"] ?? "",
        statusCode: json["status_code"],
        isMatch: json["is_match"] == 'true' ? true : false,
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "msg": msg,
        "token": token,
        "status_code": statusCode,
        "is_match": isMatch,
      };
}
