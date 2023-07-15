// {"response":"success","msg":"Steps submitted successfully","coins":"256","status_code":200}
import 'dart:convert';

StepsModel stepsModelFromJson(String str) =>
    StepsModel.fromJson(json.decode(str));

String stepsModelToJson(StepsModel data) => json.encode(data.toJson());

class StepsModel {
  StepsModel({
    required this.response,
    required this.msg,
    required this.coins,
    required this.statusCode,
  });

  String response;
  String msg;
  String coins;
  int statusCode;

  factory StepsModel.fromJson(Map<String, dynamic> json) => StepsModel(
        response: json["response"] ?? "",
        msg: json["msg"] ?? "",
        coins: json["coins"] ?? '0',
        statusCode: json["status_code"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "msg": msg,
        "coins": coins,
        "status_code": statusCode,
      };
}
