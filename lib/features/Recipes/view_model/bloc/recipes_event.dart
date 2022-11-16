part of 'recipes_bloc.dart';

abstract class RecipesEvent extends Equatable {
  const RecipesEvent();
}

class AllRecipesEvent extends RecipesEvent {
  const AllRecipesEvent();

  @override
  List<Object?> get props => [];
}

class RecipesSearchEvent extends RecipesEvent {
  final String query;

  const RecipesSearchEvent({required this.query});

  @override
  List<Object?> get props => [query];
}
