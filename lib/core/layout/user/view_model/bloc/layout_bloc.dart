import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:resturant/core/const/const.dart';
import 'package:resturant/core/layout/user/repository/base/layout_base_repository.dart';
import 'package:resturant/features/admin/AllRecipes/view/screens/all_recipes_admin_screen.dart';
import 'package:resturant/features/admin/AllUsers/view/screens/all_users_admin_screen.dart';
import 'package:resturant/features/admin/Orders/view/screens/all_orders_admin_screen.dart';
import 'package:resturant/features/user/Recipes/view/screens/favourites_screen.dart';
import 'package:resturant/features/user/Categories/view/screens/categories_screen.dart';
import 'package:resturant/features/user/Orders/view/screens/orders_screen.dart';
import 'package:resturant/features/user/Recipes/view/screens/cart_screen.dart';
import 'package:resturant/features/user/Recipes/view/screens/home_screen.dart';

import '../../../../const/params.dart';
import '../../../../utls/utls.dart';
import '../../../user/models/user_model.dart';

part 'layout_event.dart';
part 'layout_state.dart';

class LayoutBloc extends Bloc<LayoutEvent, LayoutState> {
  LayoutBloc(this.baseLayoutRepository) : super(const LayoutState()) {
    on<ChangeCurrentActiveBottomNavIndexEvent>(_changeCurrentAcutiveIndex);
    on<ActiveUserDataGetEvent>(_getActiveUserData);
    on<CurrentIndexAdminPanelChangeEvent>(_changeCurrentAcutiveIndexAdmin);
    on<ActiveUserDataUpdateEvent>(_changeActiveUserData);
    on<PasswordActiveUserUpdateEvent>(_changeActiveUserPasswordAndAccessToken);
    on<AccessTokenUpdateEvent>(_updateAccessTokenAndGetAcessToken);
    on<AccessTokenGetEvent>(_getAcessToken);
    on<PasswordVisibiltyChangeEvent>(_changePasswordVisibilty);
    on<CacheClearAndDatabseClearEvent>(_clearCache);
    on<DatabaseClearByUserIdEvent>(_clearDatabaseByUserId);
  }
  final BaseLayoutRepository baseLayoutRepository;

  Widget screens(
      {required FavouriteScreenParams favouriteScreenParams,
      required int currentIndex}) {
    var allSreens = [
      const HomeScreen(),
      const CategoriesScreen(),
      const CartScreen(),
      const OrdersScreen(),
      FavoritesScreen(
          accessToken: favouriteScreenParams.accessToken,
          userId: favouriteScreenParams.userId),
    ];
    return allSreens[currentIndex];
  }

  final List<Widget> adminScreens = [
    const AllUsersAdminScrenn(),
    const AllRecipesAdminScreen(),
    const AllOrdersAdminScreen(),
  ];
  final List<String> titlesAdminLayout = [
    'Users',
    'All Recipes',
    'All Orders',
  ];
  final List<String> titles = [
    'Home',
    'Categories',
    'Cart',
    'Orders',
    'Favorites',
  ];

  FutureOr<void> _changeCurrentAcutiveIndex(
      ChangeCurrentActiveBottomNavIndexEvent event, Emitter<LayoutState> emit) {
    emit(state.copyWith(currentIndex: event.index));
  }

  FutureOr<void> _getActiveUserData(
      ActiveUserDataGetEvent event, Emitter<LayoutState> emit) async {
    final result = await baseLayoutRepository
        .getActiveUserData(ActiveUserParams(event.accessToken));
    result.fold((l) {
      emit(state.copyWith(
          layoutRequestStatues: LayoutRequestStatues.error,
          errorMessage: l.message));
    }, (r) {
      emit(state.copyWith(
          activeUser: r,
          layoutRequestStatues: LayoutRequestStatues.success,
          errorMessage: ''));
    });
  }

  FutureOr<void> _changeCurrentAcutiveIndexAdmin(
      CurrentIndexAdminPanelChangeEvent event,
      Emitter<LayoutState> emit) async {
    emit(state.copyWith(currentIndexAdminPanel: event.index));
  }

  FutureOr<void> _changeActiveUserData(
      ActiveUserDataUpdateEvent event, Emitter<LayoutState> emit) async {
    emit(state.copyWith(
        activeUserUpdateDataRequestStatues:
            ActiveUserUpdateDataRequestStatues.loading));
    final result = await baseLayoutRepository.updateUserData(
      UserDataUpdateParams(
        email: event.email,
        name: event.name,
        token: event.accessToken,
      ),
    );
    result.fold((l) {
      emit(state.copyWith(
          activeUserUpdateDataRequestStatues:
              ActiveUserUpdateDataRequestStatues.error,
          errorMessage: l.message));
    }, (r) {
      emit(state.copyWith(
          activeUser: r,
          activeUserUpdateDataRequestStatues:
              ActiveUserUpdateDataRequestStatues.success,
          errorMessage: ''));
    });
  }

  FutureOr<void> _changeActiveUserPasswordAndAccessToken(
      PasswordActiveUserUpdateEvent event, Emitter<LayoutState> emit) async {
    emit(state.copyWith(
        changePasswordRequestStatues:
            ActiveUserUpdatePasswordRequestStatues.loading));
    final result = await baseLayoutRepository.udpagetPassword(
      UpdatePasswordParams(
        token: event.accessToken,
        newPassword: event.newPassword,
        oldPassword: event.oldPassword,
        confirmPassword: event.confirmPassword,
      ),
    );
    result.fold(
        (l) => emit(state.copyWith(
              errorMessage: l.message,
              changePasswordRequestStatues:
                  ActiveUserUpdatePasswordRequestStatues.error,
            )), (r) {
      emit(
        state.copyWith(
            errorMessage: '',
            changePasswordRequestStatues:
                ActiveUserUpdatePasswordRequestStatues.passwordUpdatedSuccess),
      );
      add(AccessTokenUpdateEvent(accessToken: r, key: 'accessToken'));
    });
  }

  FutureOr<void> _updateAccessTokenAndGetAcessToken(
      AccessTokenUpdateEvent event, Emitter<LayoutState> emit) async {
    final result = await baseLayoutRepository.updateToken(UpdateTokenParams(
      token: event.accessToken,
      key: event.key,
    ));

    result.fold(
        (l) => emit(state.copyWith(
              errorMessage: l.message,
              changePasswordRequestStatues:
                  ActiveUserUpdatePasswordRequestStatues.error,
            )), (r) {
      emit(
        state.copyWith(
            errorMessage: '',
            changePasswordRequestStatues: ActiveUserUpdatePasswordRequestStatues
                .accessTokenCachedSuccess),
      );
      add(AccessTokenGetEvent(event.key));
    });
  }

  FutureOr<void> _getAcessToken(
      AccessTokenGetEvent event, Emitter<LayoutState> emit) async {
    final result = await baseLayoutRepository
        .getAccessToken(GetAccessTokenParams(key: event.key));

    result.fold(
        (l) => emit(state.copyWith(
              errorMessage: l.message,
              changePasswordRequestStatues:
                  ActiveUserUpdatePasswordRequestStatues.error,
            )), (r) {
      accessTokenVar = r;
      emit(
        state.copyWith(
          errorMessage: '',
          changePasswordRequestStatues:
              ActiveUserUpdatePasswordRequestStatues.accessTokenGetSuccess,
        ),
      );
    });
  }

  FutureOr<void> _changePasswordVisibilty(
      PasswordVisibiltyChangeEvent event, Emitter<LayoutState> emit) async {
    emit(state.copyWith(passwordVisibilty: event.passwordVisibilty));
  }

  FutureOr<void> _clearCache(
      CacheClearAndDatabseClearEvent event, Emitter<LayoutState> emit) async {
    emit(state.copyWith(logoutRequestState: LogoutRequestState.loading));
    final result =
        await baseLayoutRepository.clearCache(CacheClearParams(event.key));
    result.fold((l) {
      emit(state.copyWith(
        errorMessage: l.message,
        logoutRequestState: LogoutRequestState.error,
      ));
    }, (r) {
      emit(
        state.copyWith(
          logoutRequestState: LogoutRequestState.cacheCleared,
          errorMessage: '',
        ),
      );

      add(DatabaseClearByUserIdEvent(
          tableName: event.tableName, userId: event.userId));
    });
  }

  FutureOr<void> _clearDatabaseByUserId(
      DatabaseClearByUserIdEvent event, Emitter<LayoutState> emit) async {
    final result = await baseLayoutRepository.deleteFavoriteDataBase(
        FavoriteDatabaseDeleteParams(
            tableName: event.tableName, userId: event.userId));

    result.fold(
      (l) => emit(state.copyWith(
          errorMessage: l.message,
          logoutRequestState: LogoutRequestState.error)),
      (r) => emit(
        state.copyWith(
          errorMessage: '',
          logoutRequestState: LogoutRequestState.databaseCleared,
        ),
      ),
    );
  }
}
