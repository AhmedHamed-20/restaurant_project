import 'package:equatable/equatable.dart';

class AllUsersDataModel extends Equatable {
  final String name;
  final String email;
  final String photo;
  final String id;
  final String role;

  const AllUsersDataModel(
      {required this.name,
      required this.email,
      required this.photo,
      required this.id,
      required this.role});

  factory AllUsersDataModel.fromJson(Map<String, dynamic> json) {
    return AllUsersDataModel(
      name: json['name'],
      email: json['email'],
      photo: json['photo'],
      id: json['_id'],
      role: json['role'],
    );
  }
  @override
  List<Object?> get props => [name, email, photo, id, role];
}
