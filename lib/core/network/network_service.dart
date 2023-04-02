import 'package:dio/dio.dart';

abstract class NetworkService {
  const NetworkService();
  Future<Response<dynamic>> getData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
    ProgressCallback? onReceiveProgress,
  });
  Future<Response<dynamic>> postData({
    required String url,
    dynamic data,
    Map<String, dynamic>? headers,
    ProgressCallback? onReceiveProgress,
    ProgressCallback? onSendProgress,
    CancelToken? cancelToken,
  });

  Future<dynamic> deleteData(
      {String? url,
      Map<String, dynamic>? query,
      Map<String, dynamic>? headers});

  Future<dynamic> patchData({
    String? url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
    dynamic data,
  });
  Future<Response<dynamic>> downloadData(
      {required String url,
      required String savedPath,
      CancelToken? cancelToken,
      void Function(int, int)? onReceive});
}
