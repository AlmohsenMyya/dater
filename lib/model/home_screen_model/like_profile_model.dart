import 'dart:convert';

LikeProfileModel likeProfileModelFromJson(String str) => LikeProfileModel.fromJson(json.decode(str));

String likeProfileModelToJson(LikeProfileModel data) => json.encode(data.toJson());

class LikeProfileModel {
  LikeProfileModel({
    required this.response,
    required this.msg,
    required this.token,
    required this.statusCode,
    required this.isMatch,
  });

  String response;
  String msg;
  String token;
  int statusCode;
  bool isMatch;

  factory LikeProfileModel.fromJson(Map<String, dynamic> json) => LikeProfileModel(
    response: json["response"] ?? "",
    msg: json["msg"] ?? "",
    token: json["token"] ?? "",
    statusCode: json["status_code"] ?? 0,
    isMatch: json["is_match"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "msg": msg,
    "token": token,
    "status_code": statusCode,
    "is_match": isMatch,
  };
}