import 'package:dio/dio.dart';
import 'package:ferma/utils/const.dart';
import 'package:ferma/utils/logger.dart';
import 'package:ferma/utils/shared_preferences.dart';

Future login(String username, String password) async {
  try {
    Response res = await Dio()
        .post('$url/login', data: {'username': username, 'password': password});

    logger.v(res);
    if (res.data['token'] != null) {
      SharedPrefs.setToken(res.data['token']);
      return true;
    }
    return false;
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

Future register(Map data) async {
  try {
    Response res = await Dio().post('$url/register', data: data);

    if (res.data['token'] != null) {
      SharedPrefs.setToken(res.data['token']);
      return true;
    }
    return false;
  } on DioError catch (e) {
    logger.e(e);
    if (e.response != null) {
      if (e.response!.data['message'] != null)
        return e.response!.data['message'];
      if (e.response!.data['email'] != null)
        return e.response!.data['email'][0];
      if (e.response!.data['username'] != null)
        return e.response!.data['username'][0];
    } else {
      return ErrorMessage.connection;
    }
  } catch (e) {
    logger.e(e);
    return ErrorMessage.general;
  }
}
