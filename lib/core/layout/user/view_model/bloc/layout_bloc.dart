import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:resturant/core/layout/user/repository/base/layout_base_repository.dart';
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
    on<ActiveUserDataGet>(_getActiveUserData);
    on<CurrentIndexAdminPanelChangeEvent>(_changeCurrentAcutiveIndexAdmin);
    on<ActiveUserDataUpdateEvent>(_changeActiveUserData);
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
    const AllUsersAdminScrenn(),
    const AllOrdersAdminScreen(),
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
      ActiveUserDataGet event, Emitter<LayoutState> emit) async {
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
}
