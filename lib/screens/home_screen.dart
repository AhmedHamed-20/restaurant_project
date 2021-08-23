import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/components/all_food_widget.dart';
import 'package:resturant/components/popular_widget.dart';
import 'package:resturant/models/bloc/cubits/cubit.dart';
import 'package:resturant/models/bloc/states/states.dart';
import 'package:resturant/models/cach/chach.dart';
import 'package:resturant/models/class_models/login_model.dart';
import 'package:resturant/models/databasae/database.dart';
import 'package:resturant/models/dio/dio.dart';
import 'package:resturant/models/dio/end_points.dart';
import 'package:resturant/widgets/all_fodods.dart';
import 'package:resturant/widgets/popular_foods.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = Appcubit.get(context);

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
            Expanded(
              flex: 4,
              child: ListView.builder(
                itemCount: 5,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      //  print(EndPoints.loginModel.status);
                      //  var token = CachFunc.getData('token');
                      //     print(DataBaseFun.storedData[0]['photourl']);
                      DioFunc.getdate(url: EndPoints.allRecipies);
                    },
                    child: allFoods(
                      name: 'Pizza',
                      context: context,
                      state: state,
                      index: index,
                      imageurl: 'assets/images/pizza.jpg',
                      price: '5',
                      description:
                          'Pizza (Italian: [ˈpittsa], Neapolitan: [ˈpittsə]) is an Italian dish consisting of a usually round',
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
