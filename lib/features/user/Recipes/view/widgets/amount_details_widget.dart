import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/core/const/base_recipes_data_model.dart';

import '../../view_model/bloc/recipes_bloc.dart';

int amount = 1;

class AmountDetailsWidget extends StatelessWidget {
  const AmountDetailsWidget({
    Key? key,
    required this.recipeDataModel,
    required this.userId,
  }) : super(key: key);
  final BaseRecipesDataModel recipeDataModel;
  final String userId;
  @override
  Widget build(BuildContext context) {
    var recipesBloc = BlocProvider.of<RecipesBloc>(context);
    return StatefulBuilder(
      builder: (context, setState) => Card(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                if (amount > 1) {
                  setState(() {
                    amount--;
                  });
                }
              },
              icon: const Icon(
                Icons.remove,
              ),
            ),
            BlocConsumer<RecipesBloc, RecipesState>(
              listener: (context, state) {},
              builder: (context, state) {
                return Text(
                  amount.toString(),
                  style: Theme.of(context).textTheme.titleMedium,
                );
              },
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  amount++;
                });
              },
              icon: const Icon(
                Icons.add,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
