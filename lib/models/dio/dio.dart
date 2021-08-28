import 'package:dio/dio.dart';

class DioFunc {
  static Response response;
  static var dio = Dio();

  static Future<dynamic> getdate(
      {String url, Map<String, dynamic> query}) async {
    // dio.options.headers = {
    //   'Postman-Token': EndPoints.token,
    // };
    return response = await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<dynamic> postData(String url, Map<String, dynamic> data) async {
    return response = await dio.post(url, data: data);
  }

  static Future<dynamic> patchdata(
      String url, Map<String, dynamic> data, String token) async {
    return response =
        await dio.patch(url, data: data, queryParameters: {'bearer': token});
  }
}
