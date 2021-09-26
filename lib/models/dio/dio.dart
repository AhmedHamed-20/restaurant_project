import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:resturant/models/dio/end_points.dart';

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
              'Content-Type': 'application/json'
            }))
        .then((value) {
      print(value);
    }).onError((error, stackTrace) {
      print(error);
      print(stackTrace);
    });
  }

  static Future<dynamic> patchCategoriedata(
      {String url, String name, String email, String token}) async {
    return response = await dio
        .patch(url,
            data: {
              'name': '${name}',
            },
            options: Options(headers: {
              'Authorization': 'Bearer ${token}',
              'Content-Type': 'application/json'
            }))
        .then((value) {
      print(value);
    }).onError((error, stackTrace) {
      print(error);
      print(stackTrace);
    });
  }

  static Future<dynamic> patchPassword(
      {String url,
      String currentPassword,
      String newPassword,
      String confirmPassword,
      String token}) async {
    return response = await dio.patch(url,
        data: {
          "passwordCurrent": "${currentPassword}",
          "password": "${newPassword}",
          "passwordConfirm": "${confirmPassword}"
        },
        options: Options(headers: {
          'Authorization': 'Bearer ${token}',
          'Content-Type': 'application/json'
        }));
  }

  static Future<dynamic> patchRecipe({
    String url,
    String name,
    int price,
    int cookingTime,
    String slug,
    List ingredients,
    File image,
    String token,
  }) async {
    String fileName = image.path.split('/').last;
    print(image.path);
    return response = await dio
        .patch(url,
            data: FormData.fromMap(
              {
                "name": "${name}",
                "price": price,
                "cookingTime": cookingTime,
                "slug": slug,
                "ingredients": ingredients,
                "imageCover": await MultipartFile.fromFile(image.path,
                    filename: fileName, contentType: MediaType('image', 'png')),
              },
            ),
            options: Options(headers: {
              'Authorization': 'Bearer ${token}',
              'Content-Type': 'application/json'
            }))
        .catchError((onError) {
      print(onError);
    });
  }

  static Future<String> uploadImage(
      File file, Map<String, dynamic> token, String id) async {
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "imageCover": await MultipartFile.fromFile(file.path,
          filename: fileName, contentType: MediaType('image', 'png')),
    });
    response = await dio.patch('${EndPoints.allRecipies + id}',
        data: formData, options: Options(headers: token));
    return response.data['id'];
  }
}
