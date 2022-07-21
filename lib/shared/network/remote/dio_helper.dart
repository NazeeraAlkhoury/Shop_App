import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        // headers: {
        //   'Content-Type': 'application/json',
        // }
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'ContentType': 'application/json',
      'lang': lang,
      'Authorization': token,
    };
    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> postData(
      {required String url,
      required Map<String, dynamic> data,
      String lang = 'en',
      String token = '',
      Map<String, dynamic>? query}) async {
    dio.options.headers = {
      'ContentType': 'application/json',
      'lang': lang,
      'Authorization': token,
    };
    return await dio.post(
      url,
      data: data,
      queryParameters: query,
    );
  }

  static Future<Response> updateData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'ContentType': 'application/json',
      'lang': lang,
      'Authorization': token ?? '',
    };
    return dio.put(
      url,
      data: data,
      queryParameters: query,
    );
  }
}
