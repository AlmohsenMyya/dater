// To parse this JSON data, do
//
//     final goalModel = goalModelFromJson(jsonString);

import 'dart:convert';

GoalModel goalModelFromJson(String str) => GoalModel.fromJson(json.decode(str));

String goalModelToJson(GoalModel data) => json.encode(data.toJson());

class GoalModel {
  GoalModel({
    required this.response,
    required this.msg,
    required this.statusCode,
  });

  String response;
  List<GoalData> msg;
  int statusCode;

  factory GoalModel.fromJson(Map<String, dynamic> json) => GoalModel(
    response: json["response"] ?? "",
    msg: List<GoalData>.from((json["msg"] ?? []).map((x) => GoalData.fromJson(x ?? {}))),
    statusCode: json["status_code"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "msg": List<dynamic>.from(msg.map((x) => x.toJson())),
    "status_code": statusCode,
  };
}

class GoalData {
  GoalData({
    required this.id,
    required this.name,
  });

  String id;
  String name;

  factory GoalData.fromJson(Map<String, dynamic> json) => GoalData(
    id: json["id"] ?? "",
    name: json["name"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
