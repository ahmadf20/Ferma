import 'dart:convert';
import 'plant_model.dart';

MyPlant myPlantFromJson(String str) => MyPlant.fromJson(json.decode(str));

class MyPlant {
  MyPlant({
    this.id,
    this.name,
    this.isDone,
    this.userId,
    this.plantId,
    this.createdAt,
    this.updatedAt,
    this.plant,
    this.checklists,
  });

  String? id;
  String? name;
  bool? isDone;
  String? userId;
  String? plantId;
  DateTime? createdAt;
  DateTime? updatedAt;
  Plant? plant;
  List<Checklist>? checklists;

  factory MyPlant.fromJson(Map<String, dynamic> json) => MyPlant(
        id: json["id"]?.toString(),
        name: json["name"]?.toString(),
        isDone: json["is_done"],
        userId: json["user_id"]?.toString(),
        plantId: json["plant_id"]?.toString(),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        plant: json["plant"] == null ? null : Plant.fromJson(json["plant"]),
        checklists: json["checklists"] == null
            ? []
            : List<Checklist>.from(
                json["checklists"].map((x) => Checklist.fromJson(x))),
      );
}

class Checklist {
  Checklist({
    this.id,
    this.title,
    this.isChecked,
    this.description,
    this.date,
    this.myplantId,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? title;
  String? description;
  String? myplantId;
  bool? isChecked;
  DateTime? date;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Checklist.fromJson(Map<String, dynamic> json) => Checklist(
        id: json["id"]?.toString(),
        title: json["title"]?.toString(),
        description: json["description"]?.toString(),
        myplantId: json["myplant_id"]?.toString(),
        isChecked: json["is_checked"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );
}

class Activity {
  Activity({
    this.id,
    this.title,
    this.time,
    this.myplantId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  String? id;
  String? title;
  String? description;
  String? myplantId;
  bool? isChecked;
  DateTime? time;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        id: json["id"]?.toString(),
        title: json["title"]?.toString(),
        myplantId: json["myplant_id"]?.toString(),
        time: json["time"] == null ? null : DateTime.parse(json["time"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"] == null
            ? null
            : DateTime.parse(json["deletedAt"]),
      );
}
