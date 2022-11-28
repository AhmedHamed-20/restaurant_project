import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/core/const/app_routes_names.dart';
import 'package:resturant/core/const/const.dart';
import 'package:resturant/features/admin/AllRecipes/view_model/bloc/recipes_admin_bloc.dart';

import '../../../../../core/const/params.dart';
import '../../../../../core/utls/utls.dart';
import '../../../../../core/widget/recipes_card_design_widget.dart';
import 'delete_recipe_alert_dialog_widget.dart';

int recipesAdminPage = 2;

class MainAdminRecipesWidget extends StatefulWidget {
  const MainAdminRecipesWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<MainAdminRecipesWidget> createState() => _MainAdminRecipesWidgetState();
}

class _MainAdminRecipesWidgetState extends State<MainAdminRecipesWidget> {
  final ScrollController scrollController = ScrollController();
  bool isEndOfRecipes = false;
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
              scrollController.offset &&
          isEndOfRecipes == false) {
        BlocProvider.of<RecipesAdminBloc>(context).add(
          RecipesAdminGetMoreEvent(
            page: recipesAdminPage.toString(),
          ),
        );
        recipesAdminPage++;
      }
    });
  }

  @override
  void dispose() {
    recipesAdminPage = 2;
    isEndOfRecipes = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var allRecipesAdminBloc = BlocProvider.of<RecipesAdminBloc>(context);
    return BlocConsumer<RecipesAdminBloc, RecipesAdminState>(
        listener: (context, state) {
      if (state.recipeAdminDeleteRequestStatues ==
          RecipeAdminDeleteRequestStatues.success) {
        flutterToast(
            msg: 'Recipe Deleted Success',
            backgroundColor: AppColors.toastSuccess,
            textColor: AppColors.white);
        Navigator.of(context).pop();
      } else if (state.recipeAdminDeleteRequestStatues ==
          RecipeAdminDeleteRequestStatues.error) {
        flutterToast(
            msg: state.errorMessage,
            backgroundColor: AppColors.toastError,
            textColor: AppColors.white);
        Navigator.of(context).pop();
      }
      isEndOfRecipes = state.isEndOfRecipes;
    }, builder: (context, state) {
      return ListView.builder(
        controller: scrollController,
        itemCount: state.recipeData!.recipeDataModel.length + 1,
        itemBuilder: (context, index) {
          if (index < state.recipeData!.recipeDataModel.length) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(
                  AppRoutesNames.recipeAdminDetailsScreen,
                  arguments: DetailAdminScreenParams(
                    recipeDataAdminModel:
                        state.recipeData!.recipeDataModel[index],
                    recipesBloc: allRecipesAdminBloc,
                  ),
                );
              },
              child: RecipesCardWidget(
                imageCover: state.recipeData!.recipeDataModel[index].imageCover,
                name: state.recipeData!.recipeDataModel[index].name,
                price: state.recipeData!.recipeDataModel[index].price,
                trailingWidget: IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return BlocProvider.value(
                          value: allRecipesAdminBloc,
                          child: DeleteRecipeAlertDialogWidget(
                            recipeId:
                                state.recipeData!.recipeDataModel[index].id,
                            recipeName:
                                state.recipeData!.recipeDataModel[index].name,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            );
          } else {
            return state.isEndOfRecipes == false
                ? const Padding(
                    padding: EdgeInsets.all(AppPadding.p10),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : const SizedBox.shrink();
          }
        },
      );
    });
  }
}
