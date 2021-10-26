// To parse this JSON data, do
//
//     final getModel = getModelFromJson(jsonString);

import 'dart:convert';

GetModel getModelFromJson(String str) => GetModel.fromJson(json.decode(str));

String getModelToJson(GetModel data) => json.encode(data.toJson());

class GetModel {
    int id;
    String title;
    int parent;
    int active;
    GetModel({
        required this.id,
        required this.title,
        required this.parent,
        required this.active,
    });


    factory GetModel.fromJson(Map<String, dynamic> json) => GetModel(
        id: json["id"],
        title: json["title"],
        parent: json["parent"],
        active: json["active"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "parent": parent,
        "active": active,
    };
}
