class ReportsModelMsg {
  String response;
  List<ReportModel> msg;
  int statusCode;

  ReportsModelMsg(
      {required this.response, required this.msg, required this.statusCode});

  factory ReportsModelMsg.fromJson(Map<String, dynamic> json) =>
      ReportsModelMsg(
        response: json["response"] ?? "",
        msg: List<ReportModel>.from(
            (json["msg"] ?? []).map((x) => ReportModel.fromJson(x ?? {}))),
        statusCode: json["status_code"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "msg": msg,
        "status_code": statusCode,
      };
}

class ReportModel {
  String id;
  String name;

  ReportModel({required this.id, required this.name});

  factory ReportModel.fromJson(Map<String, dynamic> json) => ReportModel(
        id: json["id"] ?? "",
        name: json["name"] ?? "",
      );
}
