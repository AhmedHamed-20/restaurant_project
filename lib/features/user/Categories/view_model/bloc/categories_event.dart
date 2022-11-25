part of 'categories_bloc.dart';

abstract class CategoriesEvent extends Equatable {
  const CategoriesEvent();
}

class AllCategoriesEvent extends CategoriesEvent {
  const AllCategoriesEvent();

  @override
  List<Object?> get props => [];
}

class CategoryRecipesEvent extends CategoriesEvent {
  final String categoryName;

  const CategoryRecipesEvent({required this.categoryName});

  @override
  List<Object?> get props => [categoryName];
}

class ValuesCategoryRecipesResetEvent extends CategoriesEvent {
  const ValuesCategoryRecipesResetEvent();

  @override
  List<Object?> get props => [];
}

class CategoriesMoreGetEvent extends CategoriesEvent {
  final String page;

  const CategoriesMoreGetEvent(this.page);

  @override
  List<Object?> get props => [page];
}

class CategoriesRecipesMoreGetEvent extends CategoriesEvent {
  final String categoryName;
  final String page;

  const CategoriesRecipesMoreGetEvent(
      {required this.categoryName, required this.page});

  @override
  List<Object?> get props => [categoryName, page];
}
