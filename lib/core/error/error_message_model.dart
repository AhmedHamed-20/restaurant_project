import 'package:equatable/equatable.dart';

class ServerErrorMessageModel extends Equatable {
  final String message;
  final int type;

  const ServerErrorMessageModel({required this.message, required this.type});

  factory ServerErrorMessageModel.fromJson(Map<String, dynamic> json) {
    return ServerErrorMessageModel(
        message: json['message'], type: json['statusCode']);
  }
  @override
  List<Object?> get props => [message, type];
}

class LocalErrorsMessageModel extends Equatable {
  final String errorMessage;

  const LocalErrorsMessageModel({required this.errorMessage});

  factory LocalErrorsMessageModel.fromException(Object? error) {
    return LocalErrorsMessageModel(errorMessage: error.toString());
  }
  @override
  List<Object?> get props => [errorMessage];
}
