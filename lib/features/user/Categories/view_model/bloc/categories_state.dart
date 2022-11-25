// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'categories_bloc.dart';

class CategoriesState extends Equatable {
  final CategoryModel? categoryModel;
  final CategoryRecipesModel? categoryRecipesModel;
  final String errorMessage;
  final CategoryRequestStatues categoriesRequestState;
  final CategoryRequestStatues categoriesGetMoreRequestState;
  final CategoryRequestStatues categoriesRecipesGetMoreRequestState;

  final CategoryRequestStatues categoryRecipesRequestState;
  final bool isEndOfData;
  final bool isEndOfCategoryRecipesData;

  const CategoriesState(
      {this.categoryModel,
      this.isEndOfData = false,
      this.isEndOfCategoryRecipesData = false,
      this.categoriesRecipesGetMoreRequestState =
          CategoryRequestStatues.loading,
      this.categoriesGetMoreRequestState = CategoryRequestStatues.loading,
      this.categoryRecipesModel,
      this.errorMessage = '',
      this.categoriesRequestState = CategoryRequestStatues.loading,
      this.categoryRecipesRequestState = CategoryRequestStatues.loading});

  CategoriesState copyWith({
    bool? isEndOfCategoryRecipesData,
    CategoryRequestStatues? categoriesRecipesGetMoreRequestState,
    bool? isEndOfData,
    CategoryRequestStatues? categoriesGetMoreRequestState,
    CategoryModel? categoryModel,
    CategoryRecipesModel? categoryRecipesModel,
    String? errorMessage,
    CategoryRequestStatues? categoriesRequestState,
    CategoryRequestStatues? categoryRecipesRequestState,
  }) {
    return CategoriesState(
      isEndOfCategoryRecipesData:
          isEndOfCategoryRecipesData ?? this.isEndOfCategoryRecipesData,
      categoriesRecipesGetMoreRequestState:
          categoriesRecipesGetMoreRequestState ??
              this.categoriesRecipesGetMoreRequestState,
      isEndOfData: isEndOfData ?? this.isEndOfData,
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
        isEndOfData,
        isEndOfCategoryRecipesData,
        categoriesRecipesGetMoreRequestState,
        categoriesGetMoreRequestState,
        errorMessage,
        categoriesRequestState,
        categoryRecipesRequestState,
        identityHashCode(this)
      ];
}
