import 'dart:convert';

Plant plantFromJson(String str) => Plant.fromJson(json.decode(str));

class Plant {
  Plant({
    this.id,
    this.plantName,
    this.typeId,
    this.categoryId,
    this.summary,
    this.growing,
    this.harvesting,
    this.picture,
    this.totalDays,
    this.createdAt,
    this.updatedAt,
    this.cropStatistics,
    this.category,
    this.type,
  });

  String? id;
  String? plantName;
  String? typeId;
  String? categoryId;
  String? summary;
  String? growing;
  String? harvesting;
  String? picture;
  String? totalDays;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<CropStatistic>? cropStatistics;
  PlantCategory? category;
  PlantType? type;

  factory Plant.fromJson(Map<String, dynamic> json) => Plant(
        id: json["id"]?.toString(),
        plantName: json["plant_name"]?.toString(),
        typeId: json["type_id"]?.toString(),
        categoryId: json["category_id"]?.toString(),
        summary: json["summary"]?.toString(),
        growing: json["growing"]?.toString(),
        harvesting: json["harvesting"]?.toString(),
        picture: json["picture"]?.toString(),
        totalDays: json["total_days"]?.toString(),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        cropStatistics: json["crop_statistics"] == null
            ? null
            : List<CropStatistic>.from(
                json["crop_statistics"].map((x) => CropStatistic.fromJson(x))),
        category: json["category"] == null
            ? null
            : PlantCategory.fromJson(json["category"]),
        type: json["type"] == null ? null : PlantType.fromJson(json["type"]),
      );
}

class CropStatistic {
  CropStatistic({
    this.id,
    this.germDaysLow,
    this.germTemperatureLow,
    this.growthDaysLow,
    this.heightLow,
    this.phLow,
    this.spacingLow,
    this.temperatureLow,
    this.widthLow,
    this.germDaysUp,
    this.germTemperatureUp,
    this.growthDaysUp,
    this.heightUp,
    this.phUp,
    this.spacingUp,
    this.temperatureUp,
    this.widthUp,
    this.createdAt,
    this.updatedAt,
    this.plantId,
  });

  String? id;
  String? germDaysLow;
  String? germTemperatureLow;
  String? growthDaysLow;
  String? heightLow;
  String? phLow;
  String? spacingLow;
  String? temperatureLow;
  String? widthLow;
  String? germDaysUp;
  String? germTemperatureUp;
  String? growthDaysUp;
  String? heightUp;
  String? phUp;
  String? spacingUp;
  String? temperatureUp;
  String? widthUp;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? plantId;

  factory CropStatistic.fromJson(Map<String, dynamic> json) => CropStatistic(
        id: json["id"]?.toString(),
        germDaysLow: json["germ_days_low"]?.toString(),
        germTemperatureLow: json["germ_temperature_low"]?.toString(),
        growthDaysLow: json["growth_days_low"]?.toString(),
        heightLow: json["height_low"]?.toString(),
        phLow: json["ph_low"]?.toString(),
        spacingLow: json["spacing_low"]?.toString(),
        temperatureLow: json["temperature_low"]?.toString(),
        widthLow: json["width_low"]?.toString(),
        germDaysUp: json["germ_days_up"]?.toString(),
        germTemperatureUp: json["germ_temperature_up"]?.toString(),
        growthDaysUp: json["growth_days_up"]?.toString(),
        heightUp: json["height_up"]?.toString(),
        phUp: json["ph_up"]?.toString(),
        spacingUp: json["spacing_up"]?.toString(),
        temperatureUp: json["temperature_up"]?.toString(),
        widthUp: json["width_up"]?.toString(),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        plantId: json["plant_id"].toString(),
      );
}

class PlantCategory {
  final String? id;
  final String? name;
  final String? articleId;

  PlantCategory({this.id, this.name, this.articleId});

  factory PlantCategory.fromJson(Map<String, dynamic> json) => PlantCategory(
        id: json["id"]?.toString(),
        articleId: json["article_id"]?.toString(),
        name: json["name"]?.toString(),
      );
}

class PlantType {
  final String? id;
  final String? name;

  PlantType({this.id, this.name});

  factory PlantType.fromJson(Map<String, dynamic> json) => PlantType(
        id: json["id"]?.toString(),
        name: json["name"]?.toString(),
      );
}
