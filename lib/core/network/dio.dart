import 'package:dio/dio.dart';

import 'network_service.dart';

class DioHelper extends NetworkService {
  final Dio dio;
  const DioHelper(this.dio);

  @override
  Future<Response<dynamic>> getData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
    ProgressCallback? onReceiveProgress,
  }) async {
    return await dio.get(
      url,
      queryParameters: query,
      onReceiveProgress: onReceiveProgress,
      options: Options(
        headers: headers,
      ),
    );
  }

  @override
  Future<Response<dynamic>> postData({
    required String url,
    dynamic data,
    Map<String, dynamic>? headers,
    ProgressCallback? onReceiveProgress,
    ProgressCallback? onSendProgress,
    CancelToken? cancelToken,
  }) async {
    return await dio.post(
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
      url,
      data: data,
      options: Options(headers: headers),
      cancelToken: cancelToken,
    );
  }

  @override
  Future<dynamic> deleteData(
      {String? url,
      Map<String, dynamic>? query,
      Map<String, dynamic>? headers}) async {
    return await dio.delete(
      url!,
      queryParameters: query,
      options: Options(headers: headers),
    );
  }

  @override
  Future<dynamic> patchData({
    String? url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
    dynamic data,
  }) async {
    return await dio.patch(
      data: data,
      url!,
      queryParameters: query,
      options: Options(headers: headers),
    );
  }

  @override
  Future<Response> downloadData(
      {required String url,
      required String savedPath,
      CancelToken? cancelToken,
      void Function(int p1, int p2)? onReceive}) async {
    return await dio.download(
      url,
      savedPath,
      cancelToken: cancelToken,
      onReceiveProgress: onReceive,
    );
  }
}
