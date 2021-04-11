import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ferma/models/weather_model.dart';
import 'package:ferma/utils/const.dart';
import 'package:ferma/utils/functions.dart';
import 'package:ferma/utils/logger.dart';

class WeatherService {
  static Future getWeatherData(String lat, String long) async {
    try {
      Response res = await Dio().get('$weatherUrl/forecast.json',
          queryParameters: {
            "key": weatherKey,
            "q": "$lat,$long",
            "days": "3",
          },
          options: Options(
            headers: await (getHeader() as FutureOr<Map<String, String>>),
            responseType: ResponseType.json,
          ));

      String responseJson = json.encode(res.data);

      logger.v(responseJson);

      if (res.data != null) {
        return weatherFromJson(responseJson);
      } else {
        return 'Failed to fetch data';
      }
    } on DioError catch (e) {
      logger.e(e);
      return ErrorMessage.connection;
    } catch (e) {
      logger.e(e);
      return ErrorMessage.general;
    }
  }
}
