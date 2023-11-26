import 'dart:convert';

LanguageModel languageModelFromJson(String str) =>
    LanguageModel.fromJson(json.decode(str));

String languageModelToJson(LanguageModel data) => json.encode(data.toJson());

class LanguageModel {
  LanguageModel({
    required this.response,
    required this.msg,
    required this.statusCode,
  });

  String response;
  List<LanguageData> msg;
  int statusCode;

  factory LanguageModel.fromJson(Map<String, dynamic> json) => LanguageModel(
        response: json["response"] ?? "",
        msg: List<LanguageData>.from(
            (json["msg"] ?? []).map((x) => LanguageData.fromJson(x ?? {}))),
        statusCode: json["status_code"] ?? '0',
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "msg": List<dynamic>.from(msg.map((x) => x.toJson())),
        "status_code": statusCode,
      };
}

class LanguageData {
  LanguageData({
    this.name,
    this.isSelected,
  });

  String? name;
  bool? isSelected;

  factory LanguageData.fromJson(Map<String, dynamic> json) => LanguageData(
        name: (json["name"] ?? '').toString(),
        isSelected: false,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
