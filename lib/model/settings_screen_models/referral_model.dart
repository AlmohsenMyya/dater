import 'dart:convert';

ReferralModel referralModelFromJson(String str) => ReferralModel.fromJson(json.decode(str));

String referralModelToJson(ReferralModel data) => json.encode(data.toJson());

class ReferralModel {
  ReferralModel({
    required this.response,
    required this.msg,
    required this.statusCode,
  });

  String response;
  String msg;
  int statusCode;

  factory ReferralModel.fromJson(Map<String, dynamic> json) => ReferralModel(
    response: json["response"] ?? "",
    msg: json["msg"] ?? "",
    statusCode: json["status_code"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "msg": msg,
    "status_code": statusCode,
  };
}