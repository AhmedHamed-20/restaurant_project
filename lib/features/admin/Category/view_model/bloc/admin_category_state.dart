part of 'admin_category_bloc.dart';

class AdminCategoryState extends Equatable {
  final AdminCategoryModel? categoryModel;
  final CategoryAdminAddRequestStatues categoryAdminAddRequestStatues;
  final CategoryAdminUpdateRequestStatues categoryAdminUpdateRequestStatues;
  final CategoryAdminDeleteRequestStatues categoryAdminDeleteRequestStatues;
  final CategoryAdminRequestStatues categoryAdminRequestStatues;
  final String errorMessage;

  const AdminCategoryState(
      {this.categoryModel,
      this.categoryAdminAddRequestStatues = CategoryAdminAddRequestStatues.idle,
      this.categoryAdminUpdateRequestStatues =
          CategoryAdminUpdateRequestStatues.idle,
      this.categoryAdminDeleteRequestStatues =
          CategoryAdminDeleteRequestStatues.idle,
      this.categoryAdminRequestStatues = CategoryAdminRequestStatues.loading,
      this.errorMessage = ''});

  AdminCategoryState copyWith({
    AdminCategoryModel? categoryModel,
    CategoryAdminAddRequestStatues? categoryAdminAddRequestStatues,
    CategoryAdminUpdateRequestStatues? categoryAdminUpdateRequestStatues,
    CategoryAdminDeleteRequestStatues? categoryAdminDeleteRequestStatues,
    CategoryAdminRequestStatues? categoryAdminRequestStatues,
    String? errorMessage,
  }) {
    return AdminCategoryState(
      categoryModel: categoryModel ?? this.categoryModel,
      categoryAdminAddRequestStatues:
          categoryAdminAddRequestStatues ?? this.categoryAdminAddRequestStatues,
      categoryAdminUpdateRequestStatues: categoryAdminUpdateRequestStatues ??
          this.categoryAdminUpdateRequestStatues,
      categoryAdminDeleteRequestStatues: categoryAdminDeleteRequestStatues ??
          this.categoryAdminDeleteRequestStatues,
      categoryAdminRequestStatues:
          categoryAdminRequestStatues ?? this.categoryAdminRequestStatues,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        categoryModel,
        categoryAdminAddRequestStatues,
        categoryAdminUpdateRequestStatues,
        categoryAdminDeleteRequestStatues,
        categoryAdminRequestStatues,
        errorMessage,
      ];
}
