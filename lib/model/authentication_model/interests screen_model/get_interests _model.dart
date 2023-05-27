// To parse this JSON data, do
//
//     final getIntrestModel = getIntrestModelFromJson(jsonString);

import 'dart:convert';

InterestModel getIntrestModelFromJson(String str) =>
    InterestModel.fromJson(json.decode(str));

String getIntrestModelToJson(InterestModel data) =>
    json.encode(data.toJson());

class InterestModel {
  InterestModel({
    required this.response,
    required this.msg,
    required this.statusCode,
  });

  final String response;
  final List<InterestsData> msg;
  final int statusCode;

  factory InterestModel.fromJson(Map<String, dynamic> json) =>
      InterestModel(
        response: json["response"] ?? "",
        msg: List<InterestsData>.from(
            json["msg"].map((x) => InterestsData.fromJson(x)) ?? []),
        statusCode: json["status_code"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        // "msg": List<dynamic>.from(msg.map((x) => x.toJson())),
        "status_code": statusCode,
      };
}

class InterestsData {
  InterestsData({
    required this.id,
    required this.name,
    required this.categoryName,
    required this.categoryId,
  });

  final String id;
  final String name;
  final String categoryName;
  final String categoryId;

  factory InterestsData.fromJson(Map<String, dynamic> json) => InterestsData(
        id: json["id"] ?? "",
        name: json["name"] ?? "",
        categoryName: json["category_name"] ?? "",
        categoryId: json["category_id"] ?? "",
      );

  // Map<String, dynamic> toJson() => {
  //     "id": id,
  //     "name": name,
  //     "category_name": categoryName,
  //     "category_id": categoryId,
  // };
}
