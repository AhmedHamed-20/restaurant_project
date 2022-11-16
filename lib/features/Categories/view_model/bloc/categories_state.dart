// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'categories_bloc.dart';

class CategoriesState extends Equatable {
  final CategoryModel? categoryModel;
  final CategoryRecipesModel? categoryRecipesModel;
  final String errorMessage;
  final CategoryRequestStatues categoriesRequestState;
  final CategoryRequestStatues categoryRecipesRequestState;

  const CategoriesState(
      {this.categoryModel,
      this.categoryRecipesModel,
      this.errorMessage = '',
      this.categoriesRequestState = CategoryRequestStatues.loading,
      this.categoryRecipesRequestState = CategoryRequestStatues.loading});

  CategoriesState copyWith({
    CategoryModel? categoryModel,
    CategoryRecipesModel? categoryRecipesModel,
    String? errorMessage,
    CategoryRequestStatues? categoriesRequestState,
    CategoryRequestStatues? categoryRecipesRequestState,
  }) {
    return CategoriesState(
      categoryModel: categoryModel ?? this.categoryModel,
      categoryRecipesModel: categoryRecipesModel ?? this.categoryRecipesModel,
      errorMessage: errorMessage ?? this.errorMessage,
      categoriesRequestState:
          categoriesRequestState ?? this.categoriesRequestState,
      categoryRecipesRequestState:
          categoryRecipesRequestState ?? this.categoryRecipesRequestState,
    );
  }

  @override
  List<Object?> get props => [
        categoryModel,
        categoryRecipesModel,
        errorMessage,
        categoriesRequestState,
        categoryRecipesRequestState
      ];
}
