import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ferma/models/chatbot_model.dart';
import 'package:ferma/utils/const.dart';
import 'package:ferma/utils/dio_configs.dart';
import 'package:ferma/utils/logger.dart';

class ChatbotService {
  static Future getResponse(String text, String baseUrl) async {
    try {
      Response res = await Dio().post(
        '$baseUrl/webhooks/rest/webhook',
        data: {
          'message': text,
          'sender': 1,
        },
      );

      logger.v(res);
      if (res.statusCode == null) return ErrorMessage.general;

      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        //TODO: remove this dummy
        // res.data = [
        //   {"recipient_id": "1", "text": "Hai kak, Ada yang bisa saya bantu?"}
        // ];

        return (res.data as List).map((val) => Chat.fromJson(val)).toList();
      }
      return ErrorMessage.general;
    } on DioError catch (e) {
      logger.e(e);
      if (e.response != null) {
        return e.response?.data['message'];
      } else {
        return ErrorMessage.connection;
      }
    } catch (e) {
      logger.e(e);
      return ErrorMessage.general;
    }
  }

  static Future getBaseUrl() async {
    try {
      Response res = await dio.get(
        '/chatbot/base_url',
      );

      logger.v(res);
      if (res.statusCode == null) return ErrorMessage.general;

      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        return res.data['data']['base_url'];
      }
      return ErrorMessage.general;
    } on DioError catch (e) {
      logger.e(e);
      if (e.response != null) {
        return e.response?.data['message'];
      } else {
        return ErrorMessage.connection;
      }
    } catch (e) {
      logger.e(e);
      return ErrorMessage.general;
    }
  }
}
