/*
import 'dart:convert';

LikerModel likerModelFromJson(String str) => LikerModel.fromJson(json.decode(str));

String likerModelToJson(LikerModel data) => json.encode(data.toJson());

class LikerModel {
  LikerModel({
    required this.response,
    required this.msg,
    required this.token,
    required this.statusCode,
  });

  String response;
  List<LikerData> msg;
  String token;
  int statusCode;

  factory LikerModel.fromJson(Map<String, dynamic> json) => LikerModel(
    response: json["response"] ?? "",
    msg: json["msg"].toString().toLowerCase() == "No data".toLowerCase() ? [] : List<LikerData>.from((json["msg"] ?? []).map((x) => LikerData.fromJson(x ?? {}))),
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

class LikerData {
  LikerData({
    required this.id,
    required this.name,
    required this.genderGet,
    required this.yearOfBirth,
    required this.profilePrompts,
    required this.bio,
    required this.work,
    required this.education,
    // required this.updatedAt,
    required this.verified,
    required this.genderGetId,
    required this.images,
    required this.distance,
    required this.age,
    required this.activeTime,
    required this.interest,
  });

  String id;
  String name;
  String genderGet;
  String yearOfBirth;
  String profilePrompts;
  String bio;
  String work;
  String education;
  // DateTime updatedAt;
  String verified;
  String genderGetId;
  List<LikerImage> images;
  String distance;
  String age;
  String activeTime;
  List<Interest> interest;

  factory LikerData.fromJson(Map<String, dynamic> json) => LikerData(
    id: json["id"] ?? "",
    name: json["name"] ?? "",
    genderGet: json["gender_get"] ?? "",
    yearOfBirth: json["year_of_birth"] ?? "",
    profilePrompts: json["profile_prompts"] ?? "",
    bio: json["bio"] ?? "",
    work: json["work"] ?? "",
    education: json["education"] ?? "",
    // updatedAt: DateTime.parse(json["updated_at"]),
    verified: json["verified"] ?? "",
    genderGetId: json["gender_get_id"] ?? "",
    images: List<LikerImage>.from((json["images"] ?? []).map((x) => x ?? {})),
    distance: json["distance"].toString(),
    age: json["age"].toString(),
    activeTime: json["active_time"] ?? "",
    interest: List<Interest>.from((json["interest"] ?? []).map((x) => Interest.fromJson(x ?? {}))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "gender_get": genderGet,
    "year_of_birth": yearOfBirth,
    "profile_prompts": profilePrompts,
    "bio": bio,
    "work": work,
    "education": education,
    // "updated_at": updatedAt.toIso8601String(),
    "verified": verified,
    "gender_get_id": genderGetId,
    "images": List<dynamic>.from(images.map((x) => x)),
    "distance": distance,
    "age": age,
    "active_time": activeTime,
    "interest": List<dynamic>.from(interest.map((x) => x.toJson())),
  };
}

class Interest {
  Interest({
    required this.name,
  });

  String name;

  factory Interest.fromJson(Map<String, dynamic> json) => Interest(
    name: json["name"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}

class LikerImage {
  LikerImage({
    required this.imageUrl,
  });

  String imageUrl;

  factory LikerImage.fromJson(Map<String, dynamic> json) => LikerImage(
    imageUrl: json["image_url"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "image_url": imageUrl,
  };
}*/

// To parse this JSON data, do
//
//     final likerModel = likerModelFromJson(jsonString);

import 'dart:convert';

LikerModel likerModelFromJson(String str) =>
    LikerModel.fromJson(json.decode(str));

String likerModelToJson(LikerModel data) => json.encode(data.toJson());

class LikerModel {
  String response;
  List<LikerData> msg;
  String token;
  int statusCode;

  LikerModel({
    required this.response,
    required this.msg,
    required this.token,
    required this.statusCode,
  });

  factory LikerModel.fromJson(Map<String, dynamic> json) => LikerModel(
        response: json["response"] ?? "",
        msg: json["msg"].toString().toLowerCase() == "No data".toLowerCase()
            ? []
            : List<LikerData>.from(
                (json["msg"] ?? []).map((x) => LikerData.fromJson(x ?? {}))),
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

class LikerData {
  String id;
  String name;
  String bio;
  String verified;
  List<LikerImage> images;
  String distance;
  String age;
  String activeTime;
  bool blurred;

  // List<Interest> interest;
  // List<Prompt> prompts;
  // int percentage;
  // dynamic country;
  // Basic basic;
  // dynamic languages;

  LikerData({
    required this.id,
    required this.name,
    required this.bio,
    required this.verified,
    required this.images,
    required this.distance,
    required this.age,
    required this.activeTime,
    this.blurred = true,
    // this.interest,
    // this.prompts,
    // this.percentage,
    // this.country,
    // this.basic,
    // this.languages,
  });

  factory LikerData.fromJson(Map<String, dynamic> json) => LikerData(
        id: json["id"] ?? "",
        name: json["name"] ?? "",
        bio: json["bio"] ?? "",
        verified: json["verified"] ?? "",
        images: List<LikerImage>.from(
            (json["images"] ?? []).map((x) => LikerImage.fromJson(x ?? {}))),
        distance: (json["distance"] ?? 0).toString(),
        age: (json["age"] ?? 0).toString(),
        activeTime: json["active_time"] ?? "",
        //TODO add blurred from api
        // interest: List<Interest>.from(json["interest"].map((x) => Interest.fromJson(x))),
        // prompts: List<Prompt>.from(json["prompts"].map((x) => Prompt.fromJson(x))),
        // percentage: json["percentage"],
        // country: json["country"],
        // basic: Basic.fromJson(json["basic"]),
        // languages: json["languages"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "bio": bio,
        "verified": verified,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "distance": distance,
        "age": age,
        "active_time": activeTime,
        // "interest": List<dynamic>.from(interest.map((x) => x.toJson())),
        // "prompts": List<dynamic>.from(prompts.map((x) => x.toJson())),
        // "percentage": percentage,
        // "country": country,
        // "basic": basic.toJson(),
        // "languages": languages,
      };
}

class LikerImage {
  String imageUrl;

  LikerImage({
    required this.imageUrl,
  });

  factory LikerImage.fromJson(Map<String, dynamic> json) => LikerImage(
        imageUrl: json["image_url"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "image_url": imageUrl,
      };
}

// class Basic {
//   String gender;
//   String work;
//   String education;
//   dynamic height;
//   dynamic exercise;
//   dynamic smoking;
//   dynamic drinking;
//   dynamic politics;
//   dynamic religion;
//   dynamic kids;
//   String lookingFor;
//
//   Basic({
//     this.gender,
//     this.work,
//     this.education,
//     this.height,
//     this.exercise,
//     this.smoking,
//     this.drinking,
//     this.politics,
//     this.religion,
//     this.kids,
//     this.lookingFor,
//   });
//
//   factory Basic.fromJson(Map<String, dynamic> json) => Basic(
//     gender: json["gender"],
//     work: json["work"],
//     education: json["education"],
//     height: json["height"],
//     exercise: json["exercise"],
//     smoking: json["smoking"],
//     drinking: json["drinking"],
//     politics: json["politics"],
//     religion: json["religion"],
//     kids: json["kids"],
//     lookingFor: json["looking_for"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "gender": gender,
//     "work": work,
//     "education": education,
//     "height": height,
//     "exercise": exercise,
//     "smoking": smoking,
//     "drinking": drinking,
//     "politics": politics,
//     "religion": religion,
//     "kids": kids,
//     "looking_for": lookingFor,
//   };
// }

// class Interest {
//   String name;
//
//   Interest({
//     this.name,
//   });
//
//   factory Interest.fromJson(Map<String, dynamic> json) => Interest(
//     name: json["name"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "name": name,
//   };
// }

// class Prompt {
//   String question;
//   String promptId;
//   String answer;
//
//   Prompt({
//     this.question,
//     this.promptId,
//     this.answer,
//   });
//
//   factory Prompt.fromJson(Map<String, dynamic> json) => Prompt(
//     question: json["question"],
//     promptId: json["prompt_id"],
//     answer: json["answer"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "question": question,
//     "prompt_id": promptId,
//     "answer": answer,
//   };
// }
