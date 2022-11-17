import 'package:equatable/equatable.dart';

import 'category_data.dart';

class CategoryModel extends Equatable {
  final int results;
  final List<CategoryDataModel> categoryData;

  const CategoryModel({required this.results, required this.categoryData});
  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        results: json['results'],
        categoryData: List<CategoryDataModel>.from(
            json['data']['data'].map((x) => CategoryDataModel.fromJson(x))),
      );

  @override
  List<Object?> get props => [results, categoryData];
}
