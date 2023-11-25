import 'dart:convert';

AccountActiveModel accountActiveModelFromJson(String str) =>
    AccountActiveModel.fromJson(json.decode(str));

String accountActiveModelToJson(AccountActiveModel data) =>
    json.encode(data.toJson());

class AccountActiveModel {
  AccountActiveModel({
    required this.response,
    required this.msg,
    required this.token,
    required this.statusCode,
    required this.infoCompleted,
  });

  String response;
  String msg;
  String token;
  int statusCode;
  bool infoCompleted;

  factory AccountActiveModel.fromJson(Map<String, dynamic> json) =>
      AccountActiveModel(
          response: json["response"] ?? "",
          msg: json["msg"] ?? "",
          token: json["token"] ?? "",
          statusCode: json["status_code"] ?? 0,
          infoCompleted: json["info_completed"] ?? false);

  Map<String, dynamic> toJson() => {
        "response": response,
        "msg": msg,
        "token": token,
        "status_code": statusCode,
        "info_completed": infoCompleted
      };
}
