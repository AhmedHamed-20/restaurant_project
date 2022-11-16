import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String name;
  final String email;
  final String photo;
  final String id;

  const UserModel({
    required this.name,
    required this.email,
    required this.photo,
    required this.id,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      photo: json['photo'],
      id: json['_id'],
    );
  }

  @override
  List<Object?> get props => [name, email, photo, id];
}
