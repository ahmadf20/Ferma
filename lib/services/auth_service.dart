import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ferma/models/user_model.dart';
import 'package:ferma/utils/const.dart';
import 'package:ferma/utils/dio_configs.dart';
import 'package:ferma/utils/logger.dart';

class AuthService {
  static Future login(
    String username,
    String password, {
    Function(Map?)? callback,
  }) async {
    try {
      Response res = await dio.post(
        '/auth/login',
        data: {
          'username': username,
          'password': password,
        },
      );

      logger.v(json.decode(res.toString()));

      if (res.data['status'] >= 200 && res.data['status'] < 300) {
        if (callback != null) callback(res.data['data']);
        return User.fromJson(res.data['data']['user']);
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

  static Future register(
    Map<String, dynamic> data, {
    Function(Map?)? callback,
  }) async {
    try {
      Response res = await dio.post('/auth/register', data: data);

      logger.v(json.decode(res.toString()));

      if (res.data['status'] >= 200 && res.data['status'] < 300) {
        if (callback != null) callback(res.data['data']);
        return User.fromJson(res.data['data']['user']);
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
