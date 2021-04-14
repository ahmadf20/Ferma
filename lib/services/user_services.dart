import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ferma/models/user_model.dart';
import 'package:ferma/utils/const.dart';
import 'package:ferma/utils/dio_configs.dart';
import 'package:ferma/utils/functions.dart';
import 'package:ferma/utils/logger.dart';

Future getUser() async {
  try {
    Response res = await dio.get(
      '$url/api/auth/profile',
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

// Future updateUserData(Map data) async {
//   try {
//     Response res = await dio.post(
//       '/profile',
//       data: data,
//       options: Options(headers: await (getHeader())),
//     );
//     String responseJson = json.encode(res.data['user']);

//     logger.v(responseJson);

//     if (res.data['user'] != null) {
//       return userFromJson(responseJson);
//     } else {
//       return 'Failed to fetch data';
//     }
//   } on DioError catch (e) {
//     logger.e(e);
//     if (e.response != null) {
//       if (e.response?.data['email'] != null) {
//         return e.response?.data['email'][0];
//       }
//       if (e.response?.data['username'] != null) {
//         return e.response?.data['username'][0];
//       }
//     } else {
//       return ErrorMessage.connection;
//     }
//   } catch (e) {
//     logger.e(e);
//     return ErrorMessage.general;
//   }
// }

// Future updateUserImage(String filePath) async {
//   try {
//     Response res = await dio.post(
//       '/update_pic',
//       data: FormData.fromMap({
//         'foto': await MultipartFile.fromFile(filePath),
//       }),
//       options: Options(
//         headers: {
//           'Authorization': 'Bearer ${await SharedPrefs.getToken()}',
//         },
//         responseType: ResponseType.json,
//       ),
//       onSendProgress: (received, total) {
//         if (total != -1) {
//           logger.v((received / total * 100).toStringAsFixed(0) + "%");
//         }
//       },
//     );

//     String responseJson = json.encode(res.data['user']);
//     logger.v(responseJson);

//     if (res.data['user'] != null) {
//       return userFromJson(responseJson);
//     } else {
//       return 'Failed to fetch data';
//     }
//   } on DioError catch (e) {
//     logger.e(e);
//     if (e.response != null) {
//       if (e.response?.data['message'] != null) {
//         return e.response?.data['message'];
//       }
//     } else {
//       return ErrorMessage.connection;
//     }
//   } catch (e) {
//     logger.e(e);
//     return ErrorMessage.general;
//   }
// }
