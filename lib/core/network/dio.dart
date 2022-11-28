import 'package:dio/dio.dart';

import 'endpoints.dart';

class DioHelper {
  static Response? response;
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: EndPoints.baseUrl,
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response<dynamic>?> getData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
    ProgressCallback? onReceiveProgress,
  }) async {
    return response = await dio?.get(
      url,
      queryParameters: query,
      onReceiveProgress: onReceiveProgress,
      options: Options(
        headers: headers,
      ),
    );
  }

  static Future<Response<dynamic>?> postData({
    required String url,
    dynamic data,
    Map<String, dynamic>? headers,
    ProgressCallback? onReceiveProgress,
    ProgressCallback? onSendProgress,
  }) async {
    return response = await dio?.post(
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
      url,
      data: data,
      options: Options(headers: headers),
    );
  }

  static Future<dynamic> deleteData(
      {String? url,
      Map<String, dynamic>? query,
      Map<String, dynamic>? headers}) async {
    return response = await dio!.delete(
      url!,
      queryParameters: query,
      options: Options(headers: headers),
    );
  }

  static Future<dynamic> patchData({
    String? url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
    dynamic data,
  }) async {
    return response = await dio!.patch(
      data: data,
      url!,
      queryParameters: query,
      options: Options(headers: headers),
    );
  }
}
