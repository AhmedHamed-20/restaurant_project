import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/const/const.dart';
import '../../../../../core/widget/cached_network_image_circle_photo.dart';
import '../../view_model/bloc/recipes_bloc.dart';

class MainCartWidget extends StatelessWidget {
  const MainCartWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var reicpesBloc = BlocProvider.of<RecipesBloc>(context);

    return BlocBuilder<RecipesBloc, RecipesState>(
      builder: (context, state) {
        if (state.cartModel.isEmpty) {
          return Center(
            child: Text(
              'No Items in Cart',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          );
        }
        return ListView.builder(
            itemCount: state.cartModel.length,
            itemBuilder: (context, index) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.r10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppPadding.p10),
                  child: ListTile(
                    trailing: Column(
                      children: [
                        MaterialButton(
                          color: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppRadius.r25),
                          ),
                          onPressed: () {
                            reicpesBloc.add(
                              CartRemoveEvent(
                                recipeId: state.cartModel[index].recipeId,
                              ),
                            );
                          },
                          child: Text(
                            'Remove',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: AppColors.white,
                                ),
                          ),
                        ),
                      ],
                    ),
                    leading: CachedNetworkImageCirclePhoto(
                      photoRadius: 60,
                      photoUrl: state.cartModel[index].imageCover,
                    ),
                    title: Text(
                      state.cartModel[index].name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Amount: ${state.cartModel[index].amount} x ${state.cartModel[index].price} EGP',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(
                          height: AppHeight.h4,
                        ),
                        Text(
                          'TotalPrice: ${state.cartModel[index].price * state.cartModel[index].amount} EGP',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
      },
    );
  }
}
