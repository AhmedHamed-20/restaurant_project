import 'package:equatable/equatable.dart';

class CategoryAdminRecipeDataModel extends Equatable {
  final String name;
  final String id;

  const CategoryAdminRecipeDataModel({required this.name, required this.id});

  factory CategoryAdminRecipeDataModel.fromJson(Map<String, dynamic> json) =>
      CategoryAdminRecipeDataModel(name: json['name'], id: json['_id']);

  @override
  List<Object?> get props => [name, id];
}
