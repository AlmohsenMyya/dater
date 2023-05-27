import 'dart:convert';

ProfilePromptsModel profilePromptsModelFromJson(String str) => ProfilePromptsModel.fromJson(json.decode(str));

String profilePromptsModelToJson(ProfilePromptsModel data) => json.encode(data.toJson());

class ProfilePromptsModel {
  ProfilePromptsModel({
    required this.response,
    required this.msg,
    required this.statusCode,
  });

  String response;
  List<PromptsData> msg;
  int statusCode;

  factory ProfilePromptsModel.fromJson(Map<String, dynamic> json) => ProfilePromptsModel(
    response: json["response"] ?? "",
    msg: List<PromptsData>.from((json["msg"] ?? []).map((x) => PromptsData.fromJson(x ?? {}))),
    statusCode: json["status_code"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "msg": List<dynamic>.from(msg.map((x) => x.toJson())),
    "status_code": statusCode,
  };
}

class PromptsData {
  PromptsData({
    this.id,
    this.name,
  });

  String? id;
  String? name;

  factory PromptsData.fromJson(Map<String, dynamic> json) => PromptsData(
    id: json["id"] ?? "",
    name: json["name"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}