import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/const/const.dart';
import '../../view_model/bloc/recipes_admin_bloc.dart';

class DeleteRecipeAlertDialogWidget extends StatelessWidget {
  const DeleteRecipeAlertDialogWidget({
    required this.recipeName,
    required this.recipeId,
    Key? key,
  }) : super(key: key);
  final String recipeName;
  final String recipeId;

  @override
  Widget build(BuildContext context) {
    var allRecipesAdminBloc = BlocProvider.of<RecipesAdminBloc>(context);
    return AlertDialog(
      title: Text('Are you sure you want to delete $recipeName'),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('No', style: Theme.of(context).textTheme.titleMedium)),
        TextButton(
          onPressed: () {
            allRecipesAdminBloc.add(
              DeleteRecipeAdminEvent(
                recipeId: recipeId,
                adminToken: accessTokenAdminVar,
              ),
            );
          },
          child: Text(
            'Yes',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ],
    );
  }
}
