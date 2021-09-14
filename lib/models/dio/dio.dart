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

  static Future<dynamic> deleteData(
      {String url,
      Map<String, dynamic> query,
      Map<String, dynamic> token}) async {
    return response = await dio.delete(
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
      {String url, String name, String email, String token}) async {
    return response = await dio
        .patch(url,
            data: {
              'name': '${name}',
              'email': '${email}',
            },
            options: Options(headers: {
              'Authorization': 'Bearer ${token}',
            }))
        .then((value) {
      print(value);
    }).onError((error, stackTrace) {
      print(error);
      print(stackTrace);
    });
  }
}
