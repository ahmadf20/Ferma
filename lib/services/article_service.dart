import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ferma/models/article_model.dart';
import 'package:ferma/utils/const.dart';
import 'package:ferma/utils/dio_configs.dart';
import 'package:ferma/utils/functions.dart';
import 'package:ferma/utils/logger.dart';

class ArticleService {
  static Future getAllArticles() async {
    try {
      Response res = await dio.get('/article',
          options: Options(
            headers: await getHeader(),
          ));

      logger.v(json.decode(res.toString()));

      if (res.data['status'] >= 200 && res.data['status'] < 300) {
        return (res.data['data'] as List)
            .map((val) => Article.fromJson(val))
            .toList();
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

  static Future getAllCategory() async {
    try {
      Response res = await dio.get('/article/category',
          options: Options(
            headers: await getHeader(),
          ));

      logger.v(json.decode(res.toString()));

      if (res.data['status'] >= 200 && res.data['status'] < 300) {
        return (res.data['data'] as List).map((val) => val.toString()).toList();
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
