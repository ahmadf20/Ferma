import 'package:dio/dio.dart';
import 'package:ferma/utils/const.dart';

BaseOptions options = BaseOptions(
  baseUrl: '$url/api',
  // connectTimeout: 5000,
  // receiveTimeout: 5000,
  contentType: Headers.formUrlEncodedContentType,
  responseType: ResponseType.json,
);

Dio dio = Dio(options);
