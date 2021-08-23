import 'package:dio/dio.dart';
import 'package:resturant/models/dio/end_points.dart';

class DioFunc {
  static Response response;
  static var dio = Dio();

  static Future<dynamic> getdate({String url}) async {
    // dio.options.headers = {
    //   'Postman-Token': EndPoints.token,
    // };
    return response = await dio.get(
      url,
    );
  }

  static Future<dynamic> postData(String url, Map<String, dynamic> data) async {
    return response = await dio.post(url, data: data);
  }
}
