import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/components/popular_widget.dart';
import 'package:resturant/models/bloc/cubits/cubit.dart';
import 'package:resturant/models/bloc/states/states.dart';
import 'package:resturant/screens/detailes_screen.dart';
import 'package:resturant/widgets/all_fodods.dart';
import 'package:resturant/widgets/navigate.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = Appcubit.get(context);

    return BlocConsumer<Appcubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        cubit.getRecipies();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 10),
              child: Text(
                'Popular Foods',
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Batka',
                ),
              ),
            ),
            popularWidget(context),
            Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 10),
              child: Text(
                'All Recipes',
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Batka',
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: ListView.builder(
                itemCount: cubit.allRecipies['results'],
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigate(
                        context: context,
                        Screen: DetailesScreen(
                          index: index,
                          name: cubit.allRecipies['data']['data'][index]
                              ['name'],
                          imageurl: cubit.allRecipies['data']['data'][index]
                              ['imageCover'],
                          price: cubit.allRecipies['data']['data'][index]
                                  ['price']
                              .toString(),
                          descripthion: cubit.allRecipies['data']['data'][index]
                              ['slug'],
                          Ingridients: cubit.allRecipies['data']['data'][index]
                              ['ingredients'],
                        ),
                      );
                    },
                    child: allFoods(
                      name: cubit.allRecipies['data']['data'][index]['name'],
                      context: context,
                      state: state,
                      index: index,
                      imageurl: cubit.allRecipies['data']['data'][index]
                          ['imageCover'],
                      price: cubit.allRecipies['data']['data'][index]['price']
                          .toString(),
                      description: cubit.allRecipies['data']['data'][index]
                          ['slug'],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
