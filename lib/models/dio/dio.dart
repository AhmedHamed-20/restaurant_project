import 'package:dio/dio.dart';

class DioFunc {
  static Response response;
  static var dio = Dio();

  static Future<dynamic> getdate({String url}) async {
    return response = await dio.get(url);
  }

  static void postData(String url, Map data) async {
    response = await dio.post(url, queryParameters: data);
  }
}
