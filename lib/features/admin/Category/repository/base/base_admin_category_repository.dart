import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:resturant/core/error/failure.dart';
import 'package:resturant/features/admin/Category/models/admin_category_model.dart';

abstract class BaseAdminCategoryRepository {
  Future<Either<Failure, AdminCategoryModel>> getCategories();
  Future<Either<Failure, String>> addCategory(CategoryAdminAddParams params);

  Future<Either<Failure, String>> updateCategory(
      CategoryAdminUpdateParams params);

  Future<Either<Failure, String>> deleteCategory(
      CategoryAdminDeleteParams params);
}

class CategoryAdminAddParams extends Equatable {
  final String name;
  final String adminToken;

  const CategoryAdminAddParams({
    required this.name,
    required this.adminToken,
  });

  @override
  List<Object?> get props => [
        name,
        adminToken,
      ];
}

class CategoryAdminUpdateParams extends Equatable {
  final String name;
  final String adminToken;
  final String id;

  const CategoryAdminUpdateParams({
    required this.name,
    required this.adminToken,
    required this.id,
  });

  @override
  List<Object?> get props => [
        name,
        adminToken,
        id,
      ];
}

class CategoryAdminDeleteParams extends Equatable {
  final String adminToken;
  final String id;

  const CategoryAdminDeleteParams({
    required this.adminToken,
    required this.id,
  });

  @override
  List<Object?> get props => [
        adminToken,
        id,
      ];
}
