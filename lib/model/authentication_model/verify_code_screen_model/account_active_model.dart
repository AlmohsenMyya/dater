import 'dart:convert';

AccountActiveModel accountActiveModelFromJson(String str) => AccountActiveModel.fromJson(json.decode(str));

String accountActiveModelToJson(AccountActiveModel data) => json.encode(data.toJson());

class AccountActiveModel {
  AccountActiveModel({
    required this.response,
    required this.msg,
    required this.token,
    required this.statusCode,
  });

  String response;
  String msg;
  String token;
  int statusCode;

  factory AccountActiveModel.fromJson(Map<String, dynamic> json) => AccountActiveModel(
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