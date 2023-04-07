import 'package:flutter/material.dart';

import '../../../../../core/const/const.dart';
import '../../../../../core/const/text_editing_controllers.dart';
import '../../../../../core/widget/defaults.dart';
import '../../models/recipe_data_admin_model.dart';

class MainIngredientsWidget extends StatefulWidget {
  const MainIngredientsWidget({
    Key? key,
    this.recipeAdminDataModel,
  }) : super(key: key);

  final RecipeAdminDataModel? recipeAdminDataModel;

  @override
  State<MainIngredientsWidget> createState() => _MainIngredientsWidgetState();
}

class _MainIngredientsWidgetState extends State<MainIngredientsWidget> {
  @override
  void initState() {
    super.initState();
    initControllers();
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: AppElevation.eL4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.r10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p10),
        child: Column(
          children: [
            Text('Ingredients', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: AppHeight.h10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: TextEditingControllers
                  .recipeEditIngredientsControllers.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(AppPadding.p8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Defaults.defaultTextField(
                          prefixIcon: Icon(Icons.food_bank_outlined,
                              color: Theme.of(context).iconTheme.color),
                          context: context,
                          controller: TextEditingControllers
                              .recipeEditIngredientsControllers[index],
                          title: 'Ingredient',
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              TextEditingControllers
                                  .recipeEditIngredientsControllers
                                  .removeAt(index);
                            });
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Theme.of(context).primaryColor,
                          ))
                    ],
                  ),
                );
              },
            ),
            Padding(
                padding: const EdgeInsets.all(AppPadding.p8),
                child: IconButton(
                    onPressed: () {
                      setState(() {
                        TextEditingControllers.recipeEditIngredientsControllers
                            .add(TextEditingController());
                      });
                    },
                    icon: const Icon(Icons.add)))
          ],
        ),
      ),
    );
  }

  void initControllers() {
    TextEditingControllers.recipeEditIngredientsControllers =
        widget.recipeAdminDataModel != null ? [] : [TextEditingController()];
    if (widget.recipeAdminDataModel != null) {
      TextEditingControllers.recipeEditIngredientsControllers = widget
          .recipeAdminDataModel!.ingredients
          .map((e) => TextEditingController(text: e))
          .toList();
    }
  }

  void disposeControllers() {
    for (var element
        in TextEditingControllers.recipeEditIngredientsControllers) {
      element.dispose();
    }
  }
}
