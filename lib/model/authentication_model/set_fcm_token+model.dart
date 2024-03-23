import 'dart:convert';

SetFcmTokenModel SetFcmTokenModelFromJson(String str) => SetFcmTokenModel.fromJson(json.decode(str));

String SetFcmTokenModelToJson(SetFcmTokenModel data) => json.encode(data.toJson());

class SetFcmTokenModel {
  SetFcmTokenModel({
    required this.response,
    required this.msg,
    required this.token,
    required this.statusCode,
  });

  String response;
  String msg;
  String token;
  int statusCode;

  factory SetFcmTokenModel.fromJson(Map<String, dynamic> json) => SetFcmTokenModel(
    response: json["response"] ?? "",
    msg: json["msg"] ?? "",
    token: json["token"] ?? "",
    statusCode: json["status_code"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "msg": msg,
    "token": token,
    "status_code": statusCode,
  };
}