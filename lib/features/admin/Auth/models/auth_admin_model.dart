import 'package:equatable/equatable.dart';

class AuthAdminModel extends Equatable {
  final String token;
  final String role;

  const AuthAdminModel(this.token, this.role);

  factory AuthAdminModel.fromJson(Map<String, dynamic> json) => AuthAdminModel(
      json['token'] as String, json['data']['user']['role'] as String);
  @override
  List<Object?> get props => [token];
}
