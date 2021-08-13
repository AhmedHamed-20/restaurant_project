import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/components/all_food_widget.dart';
import 'package:resturant/components/popular_widget.dart';
import 'package:resturant/models/bloc/cubits/cubit.dart';
import 'package:resturant/models/bloc/states/states.dart';
import 'package:resturant/widgets/all_fodods.dart';
import 'package:resturant/widgets/popular_foods.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Appcubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
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
            popularWidget(),
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
            allFoodWidget(state),
          ],
        );
      },
    );
  }
}
