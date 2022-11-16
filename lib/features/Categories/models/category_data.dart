// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class CategoryDataModel extends Equatable {
  final String name;
  final String id;

  const CategoryDataModel({required this.name, required this.id});

  factory CategoryDataModel.fromJson(Map<String, dynamic> json) =>
      CategoryDataModel(name: json['name'], id: json['_id']);

  @override
  List<Object?> get props => [name, id];
}
