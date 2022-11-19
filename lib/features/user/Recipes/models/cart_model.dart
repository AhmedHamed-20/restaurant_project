import 'package:resturant/core/const/base_recipes_data_model.dart';

class CartModel extends BaseRecipesDataModel {
  final int amount;
  const CartModel(
      {required super.ingredients,
      required super.name,
      required this.amount,
      required super.imageCover,
      required super.price,
      required super.category,
      required super.recipeId,
      required super.cookingTime,
      required super.slug});

  @override
  List<Object?> get props => [
        ingredients,
        name,
        amount,
        imageCover,
        price,
        category,
        recipeId,
        cookingTime,
        slug
      ];
}
