import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/core/widget/cached_network_image_circle_photo.dart';
import 'package:resturant/features/admin/AllRecipes/models/recipe_data_admin_model.dart';

import '../../../../../core/const/const.dart';
import '../../view_model/bloc/recipes_admin_bloc.dart';

class RecipeInfoImageWidget extends StatelessWidget {
  const RecipeInfoImageWidget({
    Key? key,
    required this.recipeAdminDataModel,
  }) : super(key: key);

  final RecipeAdminDataModel recipeAdminDataModel;

  @override
  Widget build(BuildContext context) {
    var recipeAdminBloc = BlocProvider.of<RecipesAdminBloc>(context);
    return GestureDetector(
      onTap: () {
        recipeAdminBloc.add(const ImagePickEvent());
      },
      child: BlocBuilder<RecipesAdminBloc, RecipesAdminState>(
        builder: (context, state) {
          return Stack(
            children: [
              state.pickedImage == ''
                  ? CachedNetworkImageCirclePhoto(
                      photoRadius: 140,
                      photoUrl: recipeAdminDataModel.imageCover,
                    )
                  : CircleAvatar(
                      radius: AppRadius.r70,
                      backgroundImage: FileImage(
                        File(state.pickedImage),
                      ),
                    ),
              CircleAvatar(
                radius: AppRadius.r70,
                backgroundColor: AppColors.black.withOpacity(0.5),
                child: Center(
                  child: Text(
                    'Pick New Image',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.white,
                        ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
