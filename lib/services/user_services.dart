import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ferma/models/user_model.dart';
import 'package:ferma/utils/const.dart';
import 'package:ferma/utils/dio_configs.dart';
import 'package:ferma/utils/functions.dart';
import 'package:ferma/utils/logger.dart';
import 'package:ferma/utils/shared_preferences.dart';

class UserService {
  static Future getUser() async {
    try {
      Response res = await dio.get(
        '/auth/profile',
        options: Options(headers: await (getHeader())),
      );

      logger.v(json.decode(res.toString()));

      if (res.data['status'] >= 200 && res.data['status'] < 300) {
        return User.fromJson(res.data['data']);
      }
      return res.data['message'];
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

  static Future updateUserData(
    Map<String, dynamic> data, {
    String? filepath,
  }) async {
    try {
      if (filepath != null) {
        data['profile_picture'] = await MultipartFile.fromFile(filepath);
      }

      Response res = await Dio().put(
        '$url/api/auth/profile',
        data: FormData.fromMap(data),
        options: Options(headers: {
          'x-access-token': '${await SharedPrefs.getToken()}',
        }),
        onSendProgress: (received, total) {
          if (total != -1) {
            logger.v((received / total * 100).toStringAsFixed(0) + "%");
          }
        },
      );

      logger.v(json.decode(res.toString()));

      if (res.data['status'] >= 200 && res.data['status'] < 300) {
        return true;
      }
      return res.data['message'];
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
