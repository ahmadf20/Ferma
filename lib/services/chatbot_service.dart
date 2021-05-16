import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ferma/models/chatbot_model.dart';
import 'package:ferma/utils/const.dart';
import 'package:ferma/utils/logger.dart';

class ChatbotService {
  static Future getResponse(String text) async {
    try {
      Response res = await Dio().post(
        'https://chabot-ferma.herokuapp.com/webhooks/rest/webhook',
        data: {
          'message': text,
          'sender': 1,
        },
      );

      logger.v(json.decode(res.toString()));
      if (res.statusCode == null) return ErrorMessage.general;

      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        //TODO: remove this dummy
        res.data = [
          {"recipient_id": "1", "text": "Hai kak, Ada yang bisa saya bantu?"}
        ];

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
}
