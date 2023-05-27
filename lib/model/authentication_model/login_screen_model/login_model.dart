// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

// String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
    LoginModel({
        required this.response,
        required this.msg,
        required this.verifyToken,
        required this.msgSent,
        required this.statusCode,
    });

    final String response;
    final String msg;
    final String verifyToken;
    final bool msgSent;
    final int statusCode;

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        response: json["response"] ?? "",
        msg: json["msg"] ?? "",
        verifyToken: json["verify_token"] ?? "",
        msgSent: json["msg_sent"] ?? false,
        statusCode: json["status_code"] ?? 0,
    );

    // Map<String, dynamic> toJson() => {
    //     "response": response,
    //     "msg": msg,
    //     "verify_token": verifyToken,
    //     "msg_sent": msgSent,
    //     "status_code": statusCode,
    // };
}
