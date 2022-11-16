import 'package:get_it/get_it.dart';
import 'package:resturant/features/Auth/repositories/remote/remote_auth_repository_impl.dart';
import 'package:resturant/features/Auth/view_model/bloc/auth_bloc.dart';
import 'package:resturant/features/Categories/repositories/base/base_category_repository.dart';
import 'package:resturant/features/Categories/repositories/remote/remote_category_repository_impl.dart';
import 'package:resturant/features/Categories/view_model/bloc/categories_bloc.dart';
import 'package:resturant/features/Orders/repositories/base/base_orders_repository.dart';
import 'package:resturant/features/Orders/repositories/remote/remote_orders_repository.dart';
import 'package:resturant/features/Orders/view_model/bloc/orders_bloc.dart';
import 'package:resturant/features/Recipes/repositories/base/base_recipe_repository.dart';
import 'package:resturant/features/Recipes/repositories/remote/remote_repository_impl.dart';

import '../../features/Auth/repositories/base/base_auth_repository.dart';
import '../../features/Recipes/view_model/bloc/recipes_bloc.dart';

var serviceLocator = GetIt.instance;

class ServiceLocator {
  static void init() {
    // blocs
    serviceLocator.registerFactory<AuthBloc>(() => AuthBloc(serviceLocator()));
    serviceLocator
        .registerFactory<RecipesBloc>(() => RecipesBloc(serviceLocator()));
    serviceLocator.registerFactory<CategoriesBloc>(
        () => CategoriesBloc(serviceLocator()));
    serviceLocator
        .registerFactory<OrdersBloc>(() => OrdersBloc(serviceLocator()));
    //repository
    serviceLocator.registerLazySingleton<BaseAuthRepository>(
        () => RemoteAuthRepositoryImpl());
    serviceLocator.registerLazySingleton<BaseRecipeRepository>(
        () => RemoteRecipesRepositoryImpl());
    serviceLocator.registerLazySingleton<BaseCategoryRepository>(
        () => RemoteCategoryRepositoryImpl());
    serviceLocator.registerLazySingleton<BaseOrderRepository>(
        () => RemoteOrdersRepository());
  }
}
