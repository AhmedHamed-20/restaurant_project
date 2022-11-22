import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/core/const/const.dart';

import '../../../../../core/const/base_recipes_data_model.dart';
import '../../../../../core/layout/user/view_model/bloc/layout_bloc.dart';
import '../widgets/amount_details_widget.dart';
import '../widgets/ingredient_details_widget.dart';
import '../widgets/orders_and_cart_buttons_details.dart';

class RecipeDetailsScreen extends StatelessWidget {
  const RecipeDetailsScreen({
    super.key,
    required this.recipeDataModel,
  });
  final BaseRecipesDataModel recipeDataModel;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        amount = 1;
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: Theme.of(context).iconTheme,
          elevation: 0,
          backgroundColor: AppColors.transparentColor,
          centerTitle: true,
          title: Text(
            recipeDataModel.name,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: screenHeight(context) * 0.3,
                width: screenWidth(context),
                child: Image.network(
                  recipeDataModel.imageCover,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: AppHeight.h10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Cooking Time: ${recipeDataModel.cookingTime.toString()} Min',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    'Price:${recipeDataModel.price.toString()} EGP',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: AppColors.iconColorGrey),
                  ),
                ],
              ),
              const SizedBox(
                height: AppHeight.h20,
              ),
              Text(
                'Ingredients',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: AppHeight.h10,
              ),
              IngredientsDetailsWidget(recipeDataModel: recipeDataModel),
              const SizedBox(
                height: AppHeight.h10,
              ),
              BlocBuilder<LayoutBloc, LayoutState>(
                builder: (context, state) {
                  return AmountDetailsWidget(
                    recipeDataModel: recipeDataModel,
                    userId: state.activeUser!.id,
                  );
                },
              ),
              const SizedBox(
                height: AppHeight.h10,
              ),
              BlocBuilder<LayoutBloc, LayoutState>(
                builder: (context, state) => OrdersAndCartDetailsButtonsWidget(
                  recipeDataModel: recipeDataModel,
                  userId: state.activeUser!.id,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
