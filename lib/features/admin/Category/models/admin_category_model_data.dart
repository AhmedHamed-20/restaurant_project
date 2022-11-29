import 'package:equatable/equatable.dart';

class AdminCategoryDataModel extends Equatable {
  final String name;
  final String id;

  const AdminCategoryDataModel({required this.name, required this.id});

  factory AdminCategoryDataModel.fromJson(Map<String, dynamic> json) =>
      AdminCategoryDataModel(name: json['name'], id: json['_id']);

  @override
  List<Object?> get props => [name, id];
}
