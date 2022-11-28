import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/core/const/const.dart';
import 'package:resturant/features/admin/AllRecipes/models/recipe_data_admin_model.dart';

import '../../../../../core/const/text_editing_controllers.dart';
import '../../view_model/bloc/recipes_admin_bloc.dart';
import '../widgets/main_ingredients_widget.dart';
import '../widgets/recipe_info_image_widget.dart';
import '../widgets/recipe_main_information_widget.dart';
import '../widgets/save_edit_dialog_widget.dart';

class RecipeDetailsAdminScreen extends StatefulWidget {
  const RecipeDetailsAdminScreen({super.key, required this.recipeDataModel});
  final RecipeAdminDataModel recipeDataModel;

  @override
  State<RecipeDetailsAdminScreen> createState() =>
      _RecipeDetailsAdminScreenState();
}

class _RecipeDetailsAdminScreenState extends State<RecipeDetailsAdminScreen> {
  @override
  void initState() {
    super.initState();
    TextEditingControllers.recipeEditIngredientsControllers = widget
        .recipeDataModel.ingredients
        .map((e) => TextEditingController(text: e))
        .toList();
    TextEditingControllers.recipeCookingTimeAdminEditScreenController.text =
        widget.recipeDataModel.cookingTime.toString();
    TextEditingControllers.recipePriceAdminEditScreenController.text =
        widget.recipeDataModel.price.toString();
    TextEditingControllers.recipeNameAdminEditScreenController.text =
        widget.recipeDataModel.name;
    newCategory = widget.recipeDataModel.category;
  }

  @override
  void dispose() async {
    newCategory = '';

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var recipeAdminBLoc = BlocProvider.of<RecipesAdminBloc>(context);
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<RecipesAdminBloc>(context)
            .add(const ImagePickedResetEvent());
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          iconTheme: Theme.of(context).iconTheme,
          backgroundColor: AppColors.transparentColor,
          title: Text(
            'Recipe Details',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          actions: [
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return BlocProvider.value(
                      value: recipeAdminBLoc,
                      child: SaveEditDialogWidget(
                        recipeId: widget.recipeDataModel.id,
                      ),
                    );
                  },
                );
              },
              icon: Icon(
                Icons.save,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p10),
            child: Column(
              children: [
                BlocProvider.value(
                  value: recipeAdminBLoc,
                  child: RecipeInfoImageWidget(widget: widget),
                ),
                const SizedBox(
                  height: AppHeight.h10,
                ),
                RecipeMainInformationWidget(
                    category: widget.recipeDataModel.category),
                const SizedBox(
                  height: AppHeight.h20,
                ),
                MainIngredientsWidget(widget: widget)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
