import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/features/admin/AllRecipes/view_model/bloc/recipes_admin_bloc.dart';

import '../../../../../core/const/const.dart';

class AddNewRecipeImageWidget extends StatelessWidget {
  const AddNewRecipeImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final allRecipesAdminBloc = BlocProvider.of<RecipesAdminBloc>(context);
    return GestureDetector(
      onTap: () {
        allRecipesAdminBloc.add(const ImagePickEvent());
      },
      child: BlocBuilder<RecipesAdminBloc, RecipesAdminState>(
        builder: (context, state) {
          return state.pickedImage == ''
              ? const CircleAvatar(
                  radius: AppRadius.r70,
                  backgroundImage: AssetImage(
                    AssetsPath.addImage,
                  ),
                )
              : CircleAvatar(
                  radius: AppRadius.r70,
                  backgroundImage: FileImage(
                    File(state.pickedImage),
                  ),
                );
        },
      ),
    );
  }
}
