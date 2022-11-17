import 'package:equatable/equatable.dart';

class OrderContentModel extends Equatable {
  final String recipeName;
  final String recipeId;
  final int recipeAmount;
  final int recipePrice;

  const OrderContentModel(
      {required this.recipeName,
      required this.recipeId,
      required this.recipeAmount,
      required this.recipePrice});

  factory OrderContentModel.fromJson(Map<String, dynamic> json) {
    return OrderContentModel(
      recipeName: json['recipeName'] as String,
      recipeId: json['recipeId'] as String,
      recipeAmount: json['recipeAmount'] as int,
      recipePrice: json['recipePrice'] as int,
    );
  }
  @override
  List<Object?> get props => [recipeName, recipeId, recipeAmount, recipePrice];
}
