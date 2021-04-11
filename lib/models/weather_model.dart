import 'dart:convert';

Weather weatherFromJson(String str) => Weather.fromJson(json.decode(str));

class Weather {
  Weather({
    this.location,
    this.current,
    this.forecast,
    this.alert,
  });

  Location? location;
  Current? current;
  Forecast? forecast;
  Alert? alert;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        location: Location.fromJson(json["location"]),
        current: Current.fromJson(json["current"]),
        forecast: Forecast.fromJson(json["forecast"]),
        alert: Alert.fromJson(json["alert"]),
      );
}

class Alert {
  Alert();

  factory Alert.fromJson(Map<String, dynamic>? json) => Alert();

  Map<String, dynamic> toJson() => {};
}

class Current {
  Current({
    this.lastUpdated,
    this.tempC,
    this.isDay,
    this.condition,
    this.windMph,
    this.humidity,
    this.visKm,
    this.uv,
  });

  String? lastUpdated;
  double? tempC;
  int? isDay;
  Condition? condition;
  double? windMph;
  double? humidity;
  double? visKm;
  double? uv;

  factory Current.fromJson(Map<String, dynamic> json) => Current(
        lastUpdated: json["last_updated"],
        tempC: json["temp_c"].toDouble(),
        isDay: json["is_day"],
        condition: Condition.fromJson(json["condition"]),
        windMph: json["wind_mph"].toDouble(),
        humidity: json["humidity"].toDouble(),
        visKm: json["vis_km"],
        uv: json["uv"],
      );
}

class Condition {
  Condition({
    this.text,
    this.icon,
  });

  String? text;
  String? icon;

  factory Condition.fromJson(Map<String, dynamic> json) => Condition(
        text: json["text"],
        icon: json["icon"],
      );
}

class Forecast {
  Forecast({
    this.forecastday,
  });

  List<Forecastday>? forecastday;

  factory Forecast.fromJson(Map<String, dynamic> json) => Forecast(
        forecastday: List<Forecastday>.from(
            json["forecastday"].map((x) => Forecastday.fromJson(x))),
      );
}

class Forecastday {
  Forecastday({
    this.date,
    this.day,
    this.astro,
  });

  DateTime? date;
  Day? day;
  Alert? astro;

  factory Forecastday.fromJson(Map<String, dynamic> json) => Forecastday(
        date: DateTime.parse(json["date"]),
        day: Day.fromJson(json["day"]),
        astro: Alert.fromJson(json["astro"]),
      );
}

class Day {
  Day({
    this.maxtempC,
    this.mintempC,
    this.avgtempC,
    this.maxwindMph,
    this.maxwindKph,
    this.avgvisKm,
    this.avghumidity,
    this.dailyWillItRain,
    this.dailyChanceOfRain,
    this.condition,
    this.uv,
  });

  double? maxtempC;
  double? mintempC;
  double? avgtempC;
  double? maxwindMph;
  double? maxwindKph;
  double? avgvisKm;
  double? avghumidity;
  int? dailyWillItRain;
  String? dailyChanceOfRain;
  Condition? condition;
  double? uv;

  factory Day.fromJson(Map<String, dynamic> json) => Day(
        maxtempC: json["maxtemp_c"].toDouble(),
        mintempC: json["mintemp_c"].toDouble(),
        avgtempC: json["avgtemp_c"].toDouble(),
        maxwindMph: json["maxwind_mph"].toDouble(),
        maxwindKph: json["maxwind_kph"].toDouble(),
        avgvisKm: json["avgvis_km"].toDouble(),
        avghumidity: json["avghumidity"].toDouble(),
        dailyWillItRain: json["daily_will_it_rain"],
        dailyChanceOfRain: json["daily_chance_of_rain"],
        condition: Condition.fromJson(json["condition"]),
        uv: json["uv"].toDouble(),
      );
}

class Location {
  Location({
    this.name,
    this.region,
    this.country,
    this.lat,
    this.lon,
    this.tzId,
    this.localtimeEpoch,
    this.localtime,
  });

  String? name;
  String? region;
  String? country;
  double? lat;
  double? lon;
  String? tzId;
  int? localtimeEpoch;
  String? localtime;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        name: json["name"],
        region: json["region"],
        country: json["country"],
        lat: json["lat"].toDouble(),
        lon: json["lon"].toDouble(),
        tzId: json["tz_id"],
        localtimeEpoch: json["localtime_epoch"],
        localtime: json["localtime"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "region": region,
        "country": country,
        "lat": lat,
        "lon": lon,
        "tz_id": tzId,
        "localtime_epoch": localtimeEpoch,
        "localtime": localtime,
      };
}
