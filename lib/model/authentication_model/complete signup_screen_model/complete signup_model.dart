import 'dart:convert';

CompleteSignupModel completeSignupModelFromJson(String str) =>
    CompleteSignupModel.fromJson(json.decode(str));

// String completeSignupModelToJson(CompleteSignupModel data) => json.encode(data.toJson());

class CompleteSignupModel {
  CompleteSignupModel({
    required this.response,
    required this.msg,
    required this.token,
    required this.statusCode,
  });

  final String response;
  final String msg;
  final String token;
  final int statusCode;

  factory CompleteSignupModel.fromJson(Map<String, dynamic> json) =>
      CompleteSignupModel(
        response: json["response"] ?? "",
        msg: json["msg"] ?? "",
        token: json["token"] ?? "",
        statusCode: json["status_code"] ?? 0,
      );

  // Map<String, dynamic> toJson() => {
  //     "response": response,
  //     "msg": msg,
  //     "token": token,
  //     "status_code": statusCode,
  // };
}
