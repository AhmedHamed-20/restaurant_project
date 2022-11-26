import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/features/admin/AllRecipes/view_model/bloc/recipes_admin_bloc.dart';

import '../../../../../core/const/const.dart';
import '../../../../../core/const/text_editing_controllers.dart';
import '../../../../../core/widget/defaults.dart';

String newCategory = '';

class RecipeMainInformationWidget extends StatelessWidget {
  const RecipeMainInformationWidget({
    required this.category,
    Key? key,
  }) : super(key: key);
  final String category;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Defaults.defaultTextField(
          context: context,
          controller:
              TextEditingControllers.recipeNameAdminEditScreenController,
          title: 'Name',
          prefixIcon:
              Icon(Icons.text_fields, color: Theme.of(context).iconTheme.color),
        ),
        const SizedBox(
          height: AppHeight.h10,
        ),
        Defaults.defaultTextField(
          context: context,
          controller:
              TextEditingControllers.recipePriceAdminEditScreenController,
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
              TextEditingControllers.recipeCookingTimeAdminEditScreenController,
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
}
