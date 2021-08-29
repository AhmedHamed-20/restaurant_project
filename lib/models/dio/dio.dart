import 'package:dio/dio.dart';

class DioFunc {
  static Response response;
  static var dio = Dio();

  static Future<dynamic> getdate(
      {String url,
      Map<String, dynamic> query,
      Map<String, dynamic> token}) async {
    return response = await dio.get(
      url,
      queryParameters: query,
      options: Options(headers: token),
    );
  }

  static Future<dynamic> postData(String url, Map<String, dynamic> data,
      {Map<String, dynamic> token}) async {
    return response =
        await dio.post(url, data: data, options: Options(headers: token));
  }

  static Future<dynamic> patchdata(
      String url, Map<String, dynamic> data, String token) async {
    return response =
        await dio.patch(url, data: data, queryParameters: {'bearer': token});
  }
}
