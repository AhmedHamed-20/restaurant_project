import 'package:get_it/get_it.dart';

import 'package:resturant/features/admin/AllRecipes/repository/base/base_admin_recipes_repository.dart';
import 'package:resturant/features/admin/AllRecipes/repository/remote/remote_admin_repository_impl.dart';
import 'package:resturant/features/admin/AllRecipes/view_model/bloc/recipes_admin_bloc.dart';
import 'package:resturant/features/admin/AllUsers/repositories/base/base_all_users_repository.dart';
import 'package:resturant/features/admin/AllUsers/repositories/remote/remote_all_users_repository.dart';
import 'package:resturant/features/admin/AllUsers/view_model/bloc/allusers_bloc.dart';
import 'package:resturant/features/admin/Auth/repository/base/base_admin_auth_repositroy.dart';
import 'package:resturant/features/admin/Auth/repository/remote/remote_admin_repository_impl.dart';
import 'package:resturant/features/admin/Auth/view_model/bloc/admin_auth_bloc.dart';
import 'package:resturant/features/admin/Category/repository/base/base_admin_category_repository.dart';
import 'package:resturant/features/admin/Category/repository/remote/remote_admin_category_repository.dart';
import 'package:resturant/features/admin/Category/view_model/bloc/admin_category_bloc.dart';
import 'package:resturant/features/admin/Orders/repository/base/base_admin_orders_repository.dart';
import 'package:resturant/features/admin/Orders/repository/remote/remote_admin_orders_repository.dart';
import 'package:resturant/features/admin/Orders/view_model/bloc/orders_admin_bloc.dart';
import 'package:resturant/features/user/Auth/repositories/remote/auth_repository_impl.dart';
import 'package:resturant/features/user/Auth/view_model/bloc/auth_bloc.dart';
import 'package:resturant/features/user/Categories/repositories/base/base_category_repository.dart';
import 'package:resturant/features/user/Categories/repositories/remote/remote_category_repository_impl.dart';
import 'package:resturant/features/user/Categories/view_model/bloc/categories_bloc.dart';
import 'package:resturant/features/user/Orders/repositories/base/base_orders_repository.dart';
import 'package:resturant/features/user/Orders/repositories/remote/remote_orders_repository.dart';
import 'package:resturant/features/user/Orders/view_model/bloc/orders_bloc.dart';
import 'package:resturant/features/user/Recipes/repositories/base/base_recipe_repository.dart';
import 'package:resturant/features/user/Recipes/repositories/impl/recipes_repository_impl.dart';

import '../../features/user/Auth/repositories/base/base_auth_repository.dart';
import '../../features/user/Recipes/view_model/bloc/recipes_bloc.dart';
import '../layout/user/repository/base/layout_base_repository.dart';
import '../layout/user/repository/remote/layout_repository_impl.dart';
import '../layout/user/view_model/bloc/layout_bloc.dart';

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
        .registerFactory<AllUsersBloc>(() => AllUsersBloc(serviceLocator()));
    serviceLocator.registerFactory<RecipesAdminBloc>(
        () => RecipesAdminBloc(serviceLocator()));
    serviceLocator
        .registerFactory<LayoutBloc>(() => LayoutBloc(serviceLocator()));
    serviceLocator
        .registerFactory<AdminAuthBloc>(() => AdminAuthBloc(serviceLocator()));
    serviceLocator.registerFactory<OrdersAdminBloc>(
        () => OrdersAdminBloc(serviceLocator()));
    serviceLocator.registerFactory<AdminCategoryBloc>(
        () => AdminCategoryBloc(serviceLocator()));
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
        () => LayoutRepositoryImpl());
    serviceLocator.registerLazySingleton<BaseAdminAuthRepository>(
        () => RemoteAutAdminRepositoryImpl());
    serviceLocator.registerLazySingleton<BaseAdminOrdersRepository>(
        () => RemoteAdminOrdersRepositoryImpl());

    serviceLocator.registerLazySingleton<BaseAdminCategoryRepository>(
        () => RemoteAdminCategoryRepository());
  }
}
