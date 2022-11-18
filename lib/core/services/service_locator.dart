import 'package:get_it/get_it.dart';
import 'package:resturant/core/layout/repository/base/layout_base_repository.dart';
import 'package:resturant/core/layout/repository/remote/layout_remote_repository_impl.dart';
import 'package:resturant/core/layout/view_model/bloc/layout_bloc.dart';
import 'package:resturant/features/admin/AllRecipes/repository/base/base_admin_recipes_repository.dart';
import 'package:resturant/features/admin/AllRecipes/repository/remote/remote_admin_repository_impl.dart';
import 'package:resturant/features/admin/AllRecipes/view_model/bloc/recipes_admin_bloc.dart';
import 'package:resturant/features/admin/AllUsers/repositories/base/base_all_users_repository.dart';
import 'package:resturant/features/admin/AllUsers/repositories/remote/remote_all_users_repository.dart';
import 'package:resturant/features/admin/AllUsers/view_model/bloc/allusers_bloc.dart';
import 'package:resturant/features/user/Auth/repositories/remote/auth_repository_impl.dart';
import 'package:resturant/features/user/Auth/view_model/bloc/auth_bloc.dart';
import 'package:resturant/features/user/Categories/repositories/base/base_category_repository.dart';
import 'package:resturant/features/user/Categories/repositories/remote/remote_category_repository_impl.dart';
import 'package:resturant/features/user/Categories/view_model/bloc/categories_bloc.dart';
import 'package:resturant/features/user/Orders/repositories/base/base_orders_repository.dart';
import 'package:resturant/features/user/Orders/repositories/remote/remote_orders_repository.dart';
import 'package:resturant/features/user/Orders/view_model/bloc/orders_bloc.dart';
import 'package:resturant/features/user/Recipes/repositories/base/base_recipe_repository.dart';
import 'package:resturant/features/user/Recipes/repositories/remote/recipes_repository_impl.dart';

import '../../features/user/Auth/repositories/base/base_auth_repository.dart';
import '../../features/user/Recipes/view_model/bloc/recipes_bloc.dart';

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
    serviceLocator
        .registerFactory<AllusersBloc>(() => AllusersBloc(serviceLocator()));
    serviceLocator.registerFactory<RecipesAdminBloc>(
        () => RecipesAdminBloc(serviceLocator()));
    serviceLocator
        .registerFactory<LayoutBloc>(() => LayoutBloc(serviceLocator()));
    //repository
    serviceLocator
        .registerLazySingleton<BaseAuthRepository>(() => AuthRepositoryImpl());
    serviceLocator.registerLazySingleton<BaseRecipeRepository>(
        () => RecipesRepositoryImpl());
    serviceLocator.registerLazySingleton<BaseCategoryRepository>(
        () => RemoteCategoryRepositoryImpl());
    serviceLocator.registerLazySingleton<BaseOrderRepository>(
        () => RemoteOrdersRepository());
    serviceLocator.registerLazySingleton<BaseAllUsersRepository>(
        () => RemoteAllUserRepositoryImpl());
    serviceLocator.registerLazySingleton<BaseAdminRecipesRepository>(
        () => RemoteAdminRecipesRepository());
    serviceLocator.registerLazySingleton<BaseLayoutRepository>(
        () => LayoutRemoteRepositoryImpl());
  }
}
