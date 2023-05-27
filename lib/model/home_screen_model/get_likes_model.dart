// To parse this JSON data, do
//
//     final getLikesModel = getLikesModelFromJson(jsonString);

import 'dart:convert';

GetLikesModel getLikesModelFromJson(String str) =>
    GetLikesModel.fromJson(json.decode(str));

String getLikesModelToJson(GetLikesModel data) => json.encode(data.toJson());

class GetLikesModel {
  GetLikesModel({
    required this.response,
    required this.msg,
    required this.token,
    required this.statusCode,
  });

  final String response;
  final List<Msg> msg;
  final String token;
  final int statusCode;

  factory GetLikesModel.fromJson(Map<String, dynamic> json) => GetLikesModel(
        response: json["response"] ?? "",
        msg: List<Msg>.from(json["msg"].map((x) => Msg.fromJson(x)) ?? []),
        token: json["token"] ?? "",
        statusCode: json["status_code"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "msg": List<dynamic>.from(msg.map((x) => x.toJson())),
        "token": token,
        "status_code": statusCode,
      };
}

class Msg {
  Msg({
    required this.id,
    required this.name,
    required this.yearOfBirth,
  });

  final String id;
  final String name;
  final String yearOfBirth;

  factory Msg.fromJson(Map<String, dynamic> json) => Msg(
        id: json["id"] ?? "",
        name: json["name"] ?? "",
        yearOfBirth: json["year_of_birth"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "year_of_birth": yearOfBirth,
      };
}
