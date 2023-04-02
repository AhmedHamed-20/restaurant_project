import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:resturant/core/layout/user/repository/base/layout_base_repository.dart';
import 'package:resturant/features/user/Recipes/view/screens/favorites_screen.dart';
import 'package:resturant/features/user/Categories/view/screens/categories_screen.dart';
import 'package:resturant/features/user/Orders/view/screens/orders_screen.dart';
import 'package:resturant/features/user/Recipes/view/screens/cart_screen.dart';
import 'package:resturant/features/user/Recipes/view/screens/home_screen.dart';

import '../../../const/params.dart';
import '../../../utls/utls.dart';
import '../../user/view_model/bloc/layout_bloc.dart';

class LayoutBloc extends Bloc<LayoutEvent, LayoutState> {
  LayoutBloc(this.baseLayoutRepository) : super(const LayoutState()) {
    on<ChangeCurrentActiveBottomNavIndexEvent>(_changeCurrentAcutiveIndex);
    on<ActiveUserDataGetEvent>(_getActiveUserData);
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
}
