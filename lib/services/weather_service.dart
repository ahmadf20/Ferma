import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ferma/models/weather_model.dart';
import 'package:ferma/utils/const.dart';
import 'package:ferma/utils/dio_configs.dart';
import 'package:ferma/utils/functions.dart';
import 'package:ferma/utils/logger.dart';

class WeatherService {
  static Future getWeatherData(String lat, String long) async {
    try {
      Response res = await dio.get('$weatherUrl/forecast.json',
          queryParameters: {
            "key": weatherKey,
            "q": "$lat,$long",
            "days": "3",
          },
          options: Options(
            headers: await (getHeader()),
            responseType: ResponseType.json,
          ));

      logger.v(json.decode(res.toString()));

      if (res.data != null) {
        return Weather.fromJson(res.data);
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
