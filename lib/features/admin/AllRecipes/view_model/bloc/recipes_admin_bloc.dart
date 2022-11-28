import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:resturant/features/admin/AllRecipes/models/recipes_model_admin.dart';
import 'package:resturant/features/admin/AllRecipes/repository/base/base_admin_recipes_repository.dart';

import '../../../../../core/utls/utls.dart';
import '../../models/recipe_data_admin_model.dart';

part 'recipes_admin_event.dart';
part 'recipes_admin_state.dart';

class RecipesAdminBloc extends Bloc<RecipesAdminEvent, RecipesAdminState> {
  RecipesAdminBloc(this.baseAdminRecipesRepository)
      : super(const RecipesAdminState()) {
    on<GetRecipesAdminEvent>(_getAdminRecipes);
    on<DeleteRecipeAdminEvent>(_deleteRecipe);
    on<UpdateRecipeAdminEvent>(_updateRecipe);
    on<RecipesAdminGetMoreEvent>(_getMoreRecipes);
    on<CategoryRecipeAdminGetEvent>(_getCategories);
    on<ImagePickEvent>(_imagePick);
    on<ImagePickedResetEvent>(_imagePickedReset);
  }
  final BaseAdminRecipesRepository baseAdminRecipesRepository;
  FutureOr<void> _getAdminRecipes(
      GetRecipesAdminEvent event, Emitter<RecipesAdminState> emit) async {
    final result = await baseAdminRecipesRepository.getAdminRecipes();
    result.fold(
      (l) => emit(state.copyWith(
        errorMessage: l.message,
        recipeAdminRequestStatues: RecipeAdminRequestStatues.error,
      )),
      (r) => emit(state.copyWith(
        recipeData: r,
        errorMessage: '',
        recipeAdminRequestStatues: RecipeAdminRequestStatues.success,
      )),
    );
  }

  FutureOr<void> _deleteRecipe(
      DeleteRecipeAdminEvent event, Emitter<RecipesAdminState> emit) async {
    emit(state.copyWith(
      recipeAdminDeleteRequestStatues: RecipeAdminDeleteRequestStatues.loading,
    ));
    final result = await baseAdminRecipesRepository.deleteRecipe(
        RecipeAdimDeleteParams(
            recipeId: event.recipeId, adminToken: event.adminToken));

    result.fold(
        (l) => emit(state.copyWith(
              errorMessage: l.message,
              recipeAdminDeleteRequestStatues:
                  RecipeAdminDeleteRequestStatues.error,
            )), (r) {
      emit(state.copyWith(
        errorMessage: '',
        recipeAdminDeleteRequestStatues:
            RecipeAdminDeleteRequestStatues.success,
      ));
      add(const GetRecipesAdminEvent());
    });
  }

  FutureOr<void> _updateRecipe(
      UpdateRecipeAdminEvent event, Emitter<RecipesAdminState> emit) async {
    emit(state.copyWith(
      recipeAdminUpdateRequestStatues: RecipeAdminUpdateRequestStatues.loading,
    ));
    final result = await baseAdminRecipesRepository.updateRecipe(
      RecipeAdimUpdateParams(
        recipeId: event.recipeId,
        adminToken: event.adminToken,
        recipeData: event.recipeData,
      ),
    );
    result.fold(
        (l) => emit(state.copyWith(
            errorMessage: l.message,
            recipeAdminUpdateRequestStatues:
                RecipeAdminUpdateRequestStatues.error)), (r) {
      emit(state.copyWith(
        errorMessage: '',
        recipeAdminUpdateRequestStatues:
            RecipeAdminUpdateRequestStatues.success,
      ));
      add(const GetRecipesAdminEvent());
    });
  }

  FutureOr<void> _getMoreRecipes(
      RecipesAdminGetMoreEvent event, Emitter<RecipesAdminState> emit) async {
    final result = await baseAdminRecipesRepository
        .getMoreAdminRecipes(MoreAdminRecipesGetParams(page: event.page));

    result.fold(
        (l) => emit(
              state.copyWith(
                errorMessage: l.message,
                isEndOfRecipes: false,
              ),
            ), (r) {
      if (r.results == 0) {
        emit(state.copyWith(
          errorMessage: '',
          isEndOfRecipes: true,
          moreRecipesGetRequestStatues: RecipeAdminRequestStatues.success,
        ));
      } else if (r.results == 10) {
        RecipesAdminModel myRecipesModel;
        myRecipesModel = state.recipeData!;

        myRecipesModel.recipeDataModel.addAll(r.recipeDataModel);

        emit(state.copyWith(
          errorMessage: '',
          recipeData: myRecipesModel,
          isEndOfRecipes: false,
          moreRecipesGetRequestStatues: RecipeAdminRequestStatues.success,
        ));
      } else {
        RecipesAdminModel myRecipesModel = state.recipeData!;
        myRecipesModel.recipeDataModel.addAll(r.recipeDataModel);
        emit(
          state.copyWith(
            errorMessage: '',
            recipeData: myRecipesModel,
            isEndOfRecipes: true,
            moreRecipesGetRequestStatues: RecipeAdminRequestStatues.success,
          ),
        );
      }
    });
  }

  FutureOr<void> _getCategories(CategoryRecipeAdminGetEvent event,
      Emitter<RecipesAdminState> emit) async {
    final result = await baseAdminRecipesRepository.getCategories();

    result.fold(
        (l) => emit(
              state.copyWith(
                errorMessage: l.message,
                categoiesRecipeAdminRequestStatues:
                    RecipeAdminRequestStatues.error,
              ),
            ), (r) {
      List<String> categories = [];
      for (var category in r.categoryData) {
        categories.add(category.name);
      }

      return emit(
        state.copyWith(
          errorMessage: '',
          categories: categories,
          categoiesRecipeAdminRequestStatues: RecipeAdminRequestStatues.success,
        ),
      );
    });
  }

  List<String> getIngredientsList(
      {required List<TextEditingController> ingredients}) {
    List<String> ingredientsList = [];
    for (var ingredient in ingredients) {
      ingredientsList.add(ingredient.text.trim());
    }
    return ingredientsList;
  }

  FutureOr<void> _imagePick(
      ImagePickEvent event, Emitter<RecipesAdminState> emit) async {
    try {
      final image = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );
      emit(
        state.copyWith(
          errorMessage: '',
          imagePickRequestStatues: RecipeAdminRequestStatues.success,
          pickedImage: image == null ? '' : image.files.first.path,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.toString(),
          pickedImage: '',
          imagePickRequestStatues: RecipeAdminRequestStatues.error,
        ),
      );
    }
  }

  FutureOr<void> _imagePickedReset(
      ImagePickedResetEvent event, Emitter<RecipesAdminState> emit) {
    emit(state.copyWith(
      pickedImage: '',
      imagePickRequestStatues: RecipeAdminRequestStatues.loading,
    ));
  }
}
