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

  factory LanguageModel.fromJson(Map<String, dynamic> json) {
    try {
      return LanguageModel(
        response: json["response"] ?? "",
        msg: List<LanguageData>.from(
          (json["msg"] ?? []).map((x) {
            try {
              return LanguageData.fromJson(x ?? {});
            } catch (e) {
              // Handle the exception (e.g., print an error message)
              print("Error parsing LanguageData: $e");
              return null; // Skip the erroneous data
            }
          }).where((data) => data != null).cast<LanguageData>(), // Remove null entries
        ),
        statusCode: json["status_code"] ?? 0,
      );
    } catch (e) {
      // Handle the exception (e.g., print an error message)
      print("Error parsing LanguageModel: $e");
      return LanguageModel(response: "", msg: [], statusCode: 0); // Return an empty model in case of an error
    }
  }


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
