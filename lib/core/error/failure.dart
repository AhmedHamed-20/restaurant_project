import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../const/app_strings.dart';

abstract class Failure extends Equatable {
  final String message;
  final int? statusCode;

  const Failure({required this.message, this.statusCode});
  @override
  List<Object?> get props => [message, statusCode];
}

class ServerFailure extends Failure {
  factory ServerFailure.fromException(Exception exception) {
    if (exception is DioError) {
      switch (exception.type) {
        case DioErrorType.connectTimeout:
          return const ServerFailure(
            message: AppStrings.connectionTimeout,
          );
        case DioErrorType.sendTimeout:
          return const ServerFailure(
            message: AppStrings.sendTimeout,
          );
        case DioErrorType.receiveTimeout:
          return const ServerFailure(
            message: AppStrings.receiveTimeout,
          );
        case DioErrorType.response:
          return ServerFailure.fromResponse(exception.response!);
        case DioErrorType.cancel:
          return const ServerFailure(
            message: AppStrings.requestCancelled,
          );
        case DioErrorType.other:
          if (exception.message.contains('SocketException') ||
              exception.message.contains('HttpException')) {
            return const ServerFailure(
              message: AppStrings.noInternet,
            );
          }
          return const ServerFailure(
            message: AppStrings.unExpectedError,
          );
      }
    } else {
      return const ServerFailure(
        message: AppStrings.unExpectedError,
      );
    }
  }

  factory ServerFailure.fromResponse(Response response) {
    if (response.statusCode == 400 ||
        response.statusCode == 401 ||
        response.statusCode == 403) {
      return ServerFailure(
        message: response.data['message'],
        statusCode: response.statusCode,
      );
    } else if (response.statusCode == 404) {
      return const ServerFailure(message: AppStrings.notFound);
    } else if (response.statusCode == 500 ||
        response.statusCode == 502 ||
        response.statusCode == 503 ||
        response.statusCode == 504) {
      return const ServerFailure(message: AppStrings.internalServerError);
    } else {
      return const ServerFailure(message: AppStrings.unExpectedError);
    }
  }
  const ServerFailure({required super.message, super.statusCode});
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message});
}

class DatabaseFailure extends Failure {
  const DatabaseFailure({required super.message});
}
