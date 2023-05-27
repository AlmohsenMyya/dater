import 'dart:convert';

CmsModel cmsModelFromJson(String str) => CmsModel.fromJson(json.decode(str));

String cmsModelToJson(CmsModel data) => json.encode(data.toJson());

class CmsModel {
  CmsModel({
    required this.response,
    required this.msg,
    required this.statusCode,
  });

  String response;
  List<CmsData> msg;
  int statusCode;

  factory CmsModel.fromJson(Map<String, dynamic> json) => CmsModel(
    response: json["response"] ?? "",
    msg: List<CmsData>.from((json["msg"] ?? []).map((x) => CmsData.fromJson(x ?? {}))),
    statusCode: json["status_code"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "msg": List<dynamic>.from(msg.map((x) => x.toJson())),
    "status_code": statusCode,
  };
}

class CmsData {
  CmsData({
    required this.name,
    required this.info,
  });

  String name;
  String info;

  factory CmsData.fromJson(Map<String, dynamic> json) => CmsData(
    name: json["name"] ?? "",
    info: json["info"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "info": info,
  };
}
