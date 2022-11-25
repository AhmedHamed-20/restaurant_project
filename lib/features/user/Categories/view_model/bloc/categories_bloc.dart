import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/utls/utls.dart';
import '../../models/category_model.dart';
import '../../models/category_recipes_model.dart';
import '../../repositories/base/base_category_repository.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc(this.baseCategoryRepository) : super(const CategoriesState()) {
    on<AllCategoriesEvent>(_getAllCategories);
    on<CategoryRecipesEvent>(_getCategoryRecipes);
    on<ValuesCategoryRecipesResetEvent>(_valuesReset);
    on<CategoriesMoreGetEvent>(_getMoreCategories);
    on<CategoriesRecipesMoreGetEvent>(_getMoreCategoriesRecipes);
  }
  final BaseCategoryRepository baseCategoryRepository;
  FutureOr<void> _getAllCategories(
      AllCategoriesEvent event, Emitter<CategoriesState> emit) async {
    final result = await baseCategoryRepository.getCategories();
    result.fold(
        (failure) => emit(state.copyWith(
            errorMessage: failure.message,
            categoriesRequestState: CategoryRequestStatues.error)),
        (categoryModel) {
      if (categoryModel.results < 10 || categoryModel.results == 0) {
        return emit(state.copyWith(
            categoryModel: categoryModel,
            errorMessage: '',
            isEndOfData: true,
            categoriesRequestState: CategoryRequestStatues.success));
      } else {
        return emit(state.copyWith(
            categoryModel: categoryModel,
            errorMessage: '',
            isEndOfData: false,
            categoriesRequestState: CategoryRequestStatues.success));
      }
    });
  }

  FutureOr<void> _getCategoryRecipes(
      CategoryRecipesEvent event, Emitter<CategoriesState> emit) async {
    final result = await baseCategoryRepository.getCategoryRecipes(
        CategoryRecipesParams(categoryName: event.categoryName));
    result.fold(
        (failure) => emit(state.copyWith(
            errorMessage: failure.message,
            categoryRecipesRequestState: CategoryRequestStatues.error)),
        (categoryRecipesModel) {
      if (categoryRecipesModel.results < 10 ||
          categoryRecipesModel.results == 0) {
        return emit(state.copyWith(
            categoryRecipesModel: categoryRecipesModel,
            errorMessage: '',
            isEndOfCategoryRecipesData: true,
            categoryRecipesRequestState: CategoryRequestStatues.success));
      } else {
        emit(state.copyWith(
            categoryRecipesModel: categoryRecipesModel,
            errorMessage: '',
            isEndOfCategoryRecipesData: false,
            categoryRecipesRequestState: CategoryRequestStatues.success));
      }
    });
  }

  FutureOr<void> _valuesReset(ValuesCategoryRecipesResetEvent event,
      Emitter<CategoriesState> emit) async {
    emit(state.copyWith(
      categoryRecipesRequestState: CategoryRequestStatues.loading,
    ));
  }

  FutureOr<void> _getMoreCategories(
      CategoriesMoreGetEvent event, Emitter<CategoriesState> emit) async {
    final result = await baseCategoryRepository
        .getMoreCategories(MoreCategoriesGetParams(event.page));
    result.fold(
        (l) => emit(state.copyWith(
            errorMessage: l.message,
            categoriesGetMoreRequestState: CategoryRequestStatues.error)), (r) {
      if (r.results == 0) {
        emit(state.copyWith(
          errorMessage: '',
          isEndOfData: true,
          categoriesGetMoreRequestState: CategoryRequestStatues.success,
        ));
      } else if (r.results == 10) {
        CategoryModel myCategoriesModel;
        myCategoriesModel = state.categoryModel!;

        myCategoriesModel.categoryData.addAll(r.categoryData);

        emit(state.copyWith(
          errorMessage: '',
          categoryModel: myCategoriesModel,
          isEndOfData: false,
          categoriesGetMoreRequestState: CategoryRequestStatues.success,
        ));
      } else {
        CategoryModel myCategoriesModel = state.categoryModel!;
        myCategoriesModel.categoryData.addAll(r.categoryData);
        emit(
          state.copyWith(
            errorMessage: '',
            categoryModel: myCategoriesModel,
            isEndOfData: true,
            categoriesGetMoreRequestState: CategoryRequestStatues.success,
          ),
        );
      }
    });
  }

  FutureOr<void> _getMoreCategoriesRecipes(CategoriesRecipesMoreGetEvent event,
      Emitter<CategoriesState> emit) async {
    final result = await baseCategoryRepository.getMoreCategoryRecipes(
      MoreCategoryRecipesParams(
        event.page,
        event.categoryName,
      ),
    );
    result.fold(
        (l) => emit(state.copyWith(
            errorMessage: l.message,
            categoriesRecipesGetMoreRequestState: CategoryRequestStatues.error,
            isEndOfCategoryRecipesData: false)), (r) {
      if (r.results == 0) {
        emit(state.copyWith(
          errorMessage: '',
          isEndOfCategoryRecipesData: true,
          categoriesRecipesGetMoreRequestState: CategoryRequestStatues.success,
        ));
      } else if (r.results == 10) {
        CategoryRecipesModel myCategoriesRecipesModel;
        myCategoriesRecipesModel = state.categoryRecipesModel!;

        myCategoriesRecipesModel.categoryRecipeDataModel
            .addAll(r.categoryRecipeDataModel);

        emit(state.copyWith(
          errorMessage: '',
          categoryRecipesModel: myCategoriesRecipesModel,
          isEndOfCategoryRecipesData: false,
          categoriesRecipesGetMoreRequestState: CategoryRequestStatues.success,
        ));
      } else {
        CategoryRecipesModel myCategoriesRecipesModel =
            state.categoryRecipesModel!;
        myCategoriesRecipesModel.categoryRecipeDataModel
            .addAll(r.categoryRecipeDataModel);
        emit(
          state.copyWith(
            errorMessage: '',
            categoryRecipesModel: myCategoriesRecipesModel,
            isEndOfCategoryRecipesData: true,
            categoriesRecipesGetMoreRequestState:
                CategoryRequestStatues.success,
          ),
        );
      }
    });
  }
}
