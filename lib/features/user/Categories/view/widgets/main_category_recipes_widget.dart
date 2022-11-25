import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/features/user/Categories/view_model/bloc/categories_bloc.dart';

import '../../../../../core/const/app_routes_names.dart';
import '../../../../../core/const/params.dart';
import '../../../../../core/widget/recipes_card_design_widget.dart';

class MainCategoryRecipesWidget extends StatelessWidget {
  const MainCategoryRecipesWidget({
    required this.scrollController,
    Key? key,
  }) : super(key: key);
  final ScrollController scrollController;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, state) {
        return ListView.builder(
            controller: scrollController,
            itemCount:
                state.categoryRecipesModel!.categoryRecipeDataModel.length + 1,
            itemBuilder: (context, index) {
              if (index <
                  state.categoryRecipesModel!.categoryRecipeDataModel.length) {
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutesNames.detailsScreen,
                        arguments: DetailScreenParams(
                            baseRecipesDataModel: state.categoryRecipesModel!
                                .categoryRecipeDataModel[index],
                            amount: 1));
                  },
                  child: RecipesCardWidget(
                    imageCover: state.categoryRecipesModel!
                        .categoryRecipeDataModel[index].imageCover,
                    name: state.categoryRecipesModel!
                        .categoryRecipeDataModel[index].name,
                    price: state.categoryRecipesModel!
                        .categoryRecipeDataModel[index].price,
                  ),
                );
              } else {
                return state.isEndOfCategoryRecipesData
                    ? const SizedBox.shrink()
                    : const Center(child: CircularProgressIndicator());
              }
            });
      },
    );
  }
}
