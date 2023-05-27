// To parse this JSON data, do
//
//     final updateLocationModel = updateLocationModelFromJson(jsonString);

import 'dart:convert';

UpdateLocationModel updateLocationModelFromJson(String str) =>
    UpdateLocationModel.fromJson(json.decode(str));

// String updateLocationModelToJson(UpdateLocationModel data) => json.encode(data.toJson());

class UpdateLocationModel {
  UpdateLocationModel({
    required this.response,
    required this.msg,
    required this.token,
    required this.statusCode,
  });

  final String response;
  final String msg;
  final String token;
  final int statusCode;

  factory UpdateLocationModel.fromJson(Map<String, dynamic> json) =>
      UpdateLocationModel(
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
