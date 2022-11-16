import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:resturant/core/error/failure.dart';

import '../../models/recipes_model.dart';

abstract class BaseRecipeRepository {
  Future<Either<Failure, RecipesModel>> getAllRecipes();
  Future<Either<Failure, RecipesModel>> searchInRecipes(SearchParams params);
}

class SearchParams extends Equatable {
  final String query;

  const SearchParams({required this.query});

  @override
  List<Object?> get props => [query];
}
