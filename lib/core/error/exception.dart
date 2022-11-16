import 'error_message_model.dart';

class ServerException implements Exception {
  final ServerErrorMessageModel serverErrorMessageModel;

  const ServerException({required this.serverErrorMessageModel});
}

class AppCacheException implements Exception {
  final LocalErrorsMessageModel localErrorsMessageModel;

  AppCacheException(this.localErrorsMessageModel);
}

class AppDataBaseException implements Exception {
  final LocalErrorsMessageModel dataBaseErrorMessageModel;

  const AppDataBaseException(this.dataBaseErrorMessageModel);
}
