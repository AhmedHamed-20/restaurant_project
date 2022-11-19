import 'package:equatable/equatable.dart';
import 'package:resturant/core/const/base_recipes_data_model.dart';
import 'package:resturant/features/user/Categories/view_model/bloc/categories_bloc.dart';

class FavouriteScreenParams extends Equatable {
  final String accessToken;
  final String userId;

  const FavouriteScreenParams(this.accessToken, this.userId);

  @override
  List<Object?> get props => [accessToken, userId];
}

class CategoryRecipesScreenParams extends Equatable {
  final String categoryName;
  final CategoriesBloc categoriesBloc;
  const CategoryRecipesScreenParams(this.categoryName, this.categoriesBloc);

  @override
  List<Object?> get props => [categoryName, categoriesBloc];
}

class DetailScreenParams extends Equatable {
  final BaseRecipesDataModel baseRecipesDataModel;
  final int amount;

  const DetailScreenParams(
      {required this.baseRecipesDataModel, required this.amount});

  @override
  List<Object?> get props => [baseRecipesDataModel, amount];
}
