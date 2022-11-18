import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/features/user/Recipes/view_model/bloc/recipes_bloc.dart';

import '../../../../../core/utls/utls.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen(
      {super.key, required this.accessToken, required this.userId});
  final String accessToken;
  final String userId;
  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<RecipesBloc>(context).add(FavouriteGetFromDataBaseEvent(
        tableName: 'favorite', userId: widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipesBloc, RecipesState>(
      builder: (context, state) {
        switch (state.favouriteRequestStatues) {
          case RecipeRequestStatues.loading:
            return const Center(child: CircularProgressIndicator());
          case RecipeRequestStatues.success:
            if (state.favouriteModel.isEmpty) {
              return const Center(
                child: Text('No Favourite Recipes'),
              );
            }
            return ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    state.favouriteModel[index].name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  leading: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      state.favouriteModel[index].imageCover,
                    ),
                  ),
                  subtitle: Text(
                    '${state.favouriteModel[index].price.toString()} EGP',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                );
              },
              itemCount: state.favouriteModel.length,
            );
          case RecipeRequestStatues.error:
            return Center(
              child: Text(state.errorMessage),
            );
        }
      },
    );
  }
}
