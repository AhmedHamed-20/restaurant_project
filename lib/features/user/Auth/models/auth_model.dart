import 'package:equatable/equatable.dart';

class AuthModel extends Equatable {
  final String token;

  const AuthModel(this.token);

  factory AuthModel.fromJson(Map<String, dynamic> json) =>
      AuthModel(json['token'] as String);
  @override
  List<Object?> get props => [token];
}
