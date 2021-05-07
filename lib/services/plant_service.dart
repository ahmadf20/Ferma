import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ferma/models/myplant_model.dart';
import 'package:ferma/models/plant_model.dart';
import 'package:ferma/utils/const.dart';
import 'package:ferma/utils/dio_configs.dart';
import 'package:ferma/utils/functions.dart';
import 'package:ferma/utils/logger.dart';

class PlantService {
  static Future getCatalogPlant() async {
    try {
      Response res = await dio.get(
        '/plant',
        options: Options(headers: await (getHeader())),
      );

      logger.v(json.decode(res.toString()));

      if (res.data['status'] >= 200 && res.data['status'] < 300) {
        return (res.data['data'] as List)
            .map((val) => Plant.fromJson(val))
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

  static Future getCatalogPlantDetail(String id) async {
    try {
      Response res = await dio.get(
        '/plant/$id',
        options: Options(headers: await (getHeader())),
      );

      logger.v(json.decode(res.toString()));

      if (res.data['status'] >= 200 && res.data['status'] < 300) {
        return Plant.fromJson(res.data['data']);
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

  static Future addMyPlant(String? id, String name) async {
    try {
      Response res = await dio.post('/myplant',
          data: {
            "plant_id": id,
            "name": name,
          },
          options: Options(headers: await getHeader()));

      logger.v(json.decode(res.toString()));

      if (res.data['status'] >= 200 && res.data['status'] < 300) {
        return res.data['success'];
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

  static Future delMyPlant(String? id) async {
    try {
      Response res = await dio.delete('/myplant/$id',
          options: Options(headers: await getHeader()));

      logger.v(json.decode(res.toString()));

      if (res.data['status'] >= 200 && res.data['status'] < 300) {
        return res.data['success'];
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

  static Future getMyPlants() async {
    try {
      Response res = await dio.get(
        '/myplant',
        options: Options(headers: await (getHeader())),
      );

      logger.v(json.decode(res.toString()));

      if (res.data['status'] >= 200 && res.data['status'] < 300) {
        return (res.data['data'] as List)
            .map((val) => MyPlant.fromJson(val))
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

  static Future getCategory() async {
    try {
      Response res = await dio.get('/plantCategory',
          options: Options(
            headers: await getHeader(),
          ));

      logger.v(json.decode(res.toString()));

      if (res.data['status'] >= 200 && res.data['status'] < 300) {
        return (res.data['data'] as List)
            .map((val) => PlantCategory.fromJson(val))
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

  static Future getPlantSuggestion(String ph, String space, String temp) async {
    try {
      Response res = await dio.post('/plantSuggestion',
          data: {
            "avg_ph": ph,
            "avg_space": space,
            "avg_temperature": temp,
          },
          options: Options(headers: await getHeader()));

      logger.v(json.decode(res.toString()));

      if (res.data['status'] >= 200 && res.data['status'] < 300) {
        return (res.data['data'] as List).map((val) {
          Plant temp = Plant.fromJson(val['plant']);
          temp.cropStatistics?.add(CropStatistic.fromJson(val));
          return temp;
        }).toList();
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
