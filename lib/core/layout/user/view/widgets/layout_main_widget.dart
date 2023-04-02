import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:resturant/core/const/app_routes_names.dart';
import 'package:resturant/core/layout/user/view_model/bloc/layout_bloc.dart';

import '../../../../const/const.dart';
import '../../../../const/params.dart';
import '../../../../widget/cached_network_image_circle_photo.dart';

class LayoutMainWidget extends StatelessWidget {
  const LayoutMainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var layoutBloc = BlocProvider.of<LayoutBloc>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.transparentColor,
        centerTitle: true,
        title: BlocBuilder<LayoutBloc, LayoutState>(
          builder: (context, state) {
            return Text(
              layoutBloc.titles[state.currentIndex],
              style: Theme.of(context).textTheme.titleLarge,
            );
          },
        ),
        actions: [
          BlocBuilder<LayoutBloc, LayoutState>(
            builder: (context, state) => GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .pushNamed(AppRoutesNames.activeUserDataInfoScreen);
              },
              child: CachedNetworkImageCirclePhoto(
                photoRadius: 40,
                photoUrl: state.activeUser!.photo,
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BlocBuilder<LayoutBloc, LayoutState>(
        builder: (context, state) {
          return BottomNavigationBar(
            selectedItemColor: Theme.of(context).primaryColor,
            unselectedItemColor: Colors.grey,
            backgroundColor: Theme.of(context).colorScheme.background,
            onTap: (index) {
              layoutBloc
                  .add(ChangeCurrentActiveBottomNavIndexEvent(index: index));
            },
            currentIndex: state.currentIndex,
            items: [
              BottomNavigationBarItem(
                backgroundColor: Theme.of(context).colorScheme.background,
                icon: const Icon(IconlyBroken.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                backgroundColor: Theme.of(context).colorScheme.background,
                icon: const Icon(IconlyBroken.category),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                backgroundColor: Theme.of(context).colorScheme.background,
                icon: const Icon(IconlyBroken.buy),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                backgroundColor: Theme.of(context).colorScheme.background,
                icon: const Icon(IconlyBroken.bag),
                label: 'Orders',
              ),
              BottomNavigationBarItem(
                backgroundColor: Theme.of(context).colorScheme.background,
                icon: const Icon(IconlyBroken.heart),
                label: 'Favorites',
              ),
            ],
          );
        },
      ),
      body: BlocBuilder<LayoutBloc, LayoutState>(builder: (context, state) {
        return layoutBloc.screens(
            favouriteScreenParams:
                FavouriteScreenParams(accessTokenVar, state.activeUser!.id),
            currentIndex: state.currentIndex);
      }),
    );
  }
}
