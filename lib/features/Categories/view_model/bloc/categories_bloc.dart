import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:resturant/features/Categories/models/category_model.dart';
import 'package:resturant/features/Categories/repositories/base/base_category_repository.dart';

import '../../../../core/utls/utls.dart';
import '../../models/category_recipes_model.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc(this.baseCategoryRepository) : super(const CategoriesState()) {
    on<AllCategoriesEvent>(_getAllCategories);
    on<CategoryRecipesEvent>(_getCategoryRecipes);
  }
  final BaseCategoryRepository baseCategoryRepository;
  FutureOr<void> _getAllCategories(
      AllCategoriesEvent event, Emitter<CategoriesState> emit) async {
    final result = await baseCategoryRepository.getCategories();
    result.fold(
      (failure) => emit(state.copyWith(
          errorMessage: failure.message,
          categoriesRequestState: CategoryRequestStatues.error)),
      (categoryModel) => emit(state.copyWith(
          categoryModel: categoryModel,
          errorMessage: '',
          categoriesRequestState: CategoryRequestStatues.success)),
    );
  }

  FutureOr<void> _getCategoryRecipes(
      CategoryRecipesEvent event, Emitter<CategoriesState> emit) async {
    final result = await baseCategoryRepository.getCategoryRecipes(
        CategoryRecipesParams(categoryName: event.categoryName));
    result.fold(
      (failure) => emit(state.copyWith(
          errorMessage: failure.message,
          categoryRecipesRequestState: CategoryRequestStatues.error)),
      (categoryRecipesModel) => emit(state.copyWith(
          categoryRecipesModel: categoryRecipesModel,
          errorMessage: '',
          categoryRecipesRequestState: CategoryRequestStatues.success)),
    );
  }
}
