import 'dart:convert';

UserPhotoUploadModel userPhotoUploadModelFromJson(String str) => UserPhotoUploadModel.fromJson(json.decode(str));

String userPhotoUploadModelToJson(UserPhotoUploadModel data) => json.encode(data.toJson());

class UserPhotoUploadModel {
  UserPhotoUploadModel({
    required this.status,
    required this.addedFile,
    required this.msg,
    required this.file,
    required this.statusCode,
  });

  String status;
  AddedFile addedFile;
  String msg;
  FileClass file;
  int statusCode;

  factory UserPhotoUploadModel.fromJson(Map<String, dynamic> json) => UserPhotoUploadModel(
    status: json["status"] ?? "",
    addedFile: AddedFile.fromJson(json["added_file"] ?? {}),
    msg: json["msg"] ?? "",
    file: FileClass.fromJson(json["file"] ?? {}),
    statusCode: json["status_code"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "added_file": addedFile.toJson(),
    "msg": msg,
    "file": file.toJson(),
    "status_code": statusCode,
  };
}

class AddedFile {
  AddedFile({
    required this.id,
    required this.targetPath,
  });

  int id;
  String targetPath;

  factory AddedFile.fromJson(Map<String, dynamic> json) => AddedFile(
    id: json["id"] ?? 0,
    targetPath: json["target_path"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "target_path": targetPath,
  };
}

class FileClass {
  FileClass({
    required this.name,
    required this.type,
    required this.tmpName,
    required this.error,
    required this.size,
  });

  String name;
  String type;
  String tmpName;
  int error;
  int size;

  factory FileClass.fromJson(Map<String, dynamic> json) => FileClass(
    name: json["name"] ?? "",
    type: json["type"] ?? "",
    tmpName: json["tmp_name"] ?? "",
    error: json["error"] ?? 0,
    size: json["size"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "type": type,
    "tmp_name": tmpName,
    "error": error,
    "size": size,
  };
}
