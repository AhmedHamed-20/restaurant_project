import 'package:equatable/equatable.dart';

import 'admin_category_model_data.dart';

class AdminCategoryModel extends Equatable {
  final int results;
  final List<AdminCategoryDataModel> categoryData;

  const AdminCategoryModel({required this.results, required this.categoryData});
  factory AdminCategoryModel.fromJson(Map<String, dynamic> json) =>
      AdminCategoryModel(
        results: json['results'],
        categoryData: List<AdminCategoryDataModel>.from(json['data']['data']
            .map((x) => AdminCategoryDataModel.fromJson(x))),
      );

  @override
  List<Object?> get props => [results, categoryData];
}
