import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/features/admin/AllRecipes/view_model/bloc/recipes_admin_bloc.dart';

import '../../../../../core/const/const.dart';
import '../../../../../core/const/text_editing_controllers.dart';
import '../../../../../core/widget/defaults.dart';
import '../../models/recipe_data_admin_model.dart';

String newCategory = '';

class RecipeMainInformationWidget extends StatefulWidget {
  const RecipeMainInformationWidget({
    this.recipeAdminDataModel,
    Key? key,
  }) : super(key: key);
  final RecipeAdminDataModel? recipeAdminDataModel;

  @override
  State<RecipeMainInformationWidget> createState() =>
      _RecipeMainInformationWidgetState();
}

class _RecipeMainInformationWidgetState
    extends State<RecipeMainInformationWidget> {
  @override
  void initState() {
    super.initState();
    initTextEditingControllers();
  }

  @override
  void dispose() {
    disposeTextEditingControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Defaults.defaultTextField(
          context: context,
          controller: TextEditingControllers.recipeNameAdminScreenController,
          title: 'Name',
          prefixIcon:
              Icon(Icons.text_fields, color: Theme.of(context).iconTheme.color),
        ),
        const SizedBox(
          height: AppHeight.h10,
        ),
        Defaults.defaultTextField(
          context: context,
          controller: TextEditingControllers.recipePriceAdminScreenController,
          title: 'price',
          prefixIcon: Icon(Icons.monetization_on,
              color: Theme.of(context).iconTheme.color),
        ),
        const SizedBox(
          height: AppHeight.h10,
        ),
        Defaults.defaultTextField(
          context: context,
          controller:
              TextEditingControllers.recipeCookingTimeAdminScreenController,
          title: 'Cooking Time',
          prefixIcon:
              Icon(Icons.timelapse, color: Theme.of(context).iconTheme.color),
        ),
        const SizedBox(
          height: AppHeight.h10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Category',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            BlocBuilder<RecipesAdminBloc, RecipesAdminState>(
              builder: (context, state) => StatefulBuilder(
                builder: (context, setState) => DropdownButton<String>(
                    style: Theme.of(context).textTheme.titleLarge,
                    value: newCategory,
                    items: state.categories
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        newCategory = value!;
                      });
                    }),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void initTextEditingControllers() {
    TextEditingControllers.recipeCookingTimeAdminScreenController =
        TextEditingController();
    TextEditingControllers.recipePriceAdminScreenController =
        TextEditingController();
    TextEditingControllers.recipeNameAdminScreenController =
        TextEditingController();
    newCategory = 'drinks';
    if (widget.recipeAdminDataModel != null) {
      TextEditingControllers.recipeCookingTimeAdminScreenController.text =
          widget.recipeAdminDataModel!.cookingTime.toString();
      TextEditingControllers.recipePriceAdminScreenController.text =
          widget.recipeAdminDataModel!.price.toString();
      TextEditingControllers.recipeNameAdminScreenController.text =
          widget.recipeAdminDataModel!.name;
      newCategory = widget.recipeAdminDataModel!.category;
    }
  }

  void disposeTextEditingControllers() {
    TextEditingControllers.recipeCookingTimeAdminScreenController.dispose();
    TextEditingControllers.recipePriceAdminScreenController.dispose();
    TextEditingControllers.recipeNameAdminScreenController.dispose();
  }
}
