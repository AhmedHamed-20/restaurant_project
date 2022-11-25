import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/core/const/const.dart';
import 'package:resturant/features/user/Recipes/view_model/bloc/recipes_bloc.dart';

import '../../../../../core/const/app_routes_names.dart';
import '../../../../../core/widget/recipes_card_design_widget.dart';

class AllRecipesMainWidget extends StatefulWidget {
  const AllRecipesMainWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<AllRecipesMainWidget> createState() => _AllRecipesMainWidgetState();
}

class _AllRecipesMainWidgetState extends State<AllRecipesMainWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecipesBloc, RecipesState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.recipesModel!.recipeDataModel.length + 1,
            itemBuilder: (context, index) {
              if (index < state.recipesModel!.recipeDataModel.length) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      AppRoutesNames.detailsScreen,
                      arguments: state.recipesModel!.recipeDataModel[index],
                    );
                  },
                  child: RecipesCardWidget(
                      imageCover:
                          state.recipesModel!.recipeDataModel[index].imageCover,
                      name: state.recipesModel!.recipeDataModel[index].name,
                      price: state.recipesModel!.recipeDataModel[index].price),
                );
              } else {
                return state.isEndOfData
                    ? const SizedBox.shrink()
                    : const Padding(
                        padding: EdgeInsets.all(AppPadding.p10),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
              }
            });
      },
    );
  }
}
