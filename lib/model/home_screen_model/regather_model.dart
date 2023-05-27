import 'dart:convert';

RegatherModel regatherModelFromJson(String str) => RegatherModel.fromJson(json.decode(str));

String regatherModelToJson(RegatherModel data) => json.encode(data.toJson());

class RegatherModel {
  String response;
  String msg;
  String token;
  int statusCode;

  RegatherModel({
    required this.response,
    required this.msg,
    required this.token,
    required this.statusCode,
  });

  factory RegatherModel.fromJson(Map<String, dynamic> json) => RegatherModel(
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