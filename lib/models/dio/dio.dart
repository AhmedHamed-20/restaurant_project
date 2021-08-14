import 'package:dio/dio.dart';

class DioFunc {
  static Response response;
  static var dio = Dio();

  static getdate({String url}) async {
    response = await dio.get(url);
  }
}
