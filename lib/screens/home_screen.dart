import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/components/popular_widget.dart';
import 'package:resturant/models/bloc/cubits/cubit.dart';
import 'package:resturant/models/bloc/states/states.dart';
import 'package:resturant/models/databasae/database.dart';
import 'package:resturant/models/dio/end_points.dart';
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
        cubit.checkConnecthion();
        return cubit.result
            ? EndPoints.allRecipiesMap == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, bottom: 10, top: 10),
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
                        Container(
                            height: MediaQuery.of(context).size.height * 0.3,
                            child: popularWidget(context)),
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
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: EndPoints.allRecipiesMap['results'],
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  // cubit.getbyuseridandFavorite(
                                  //     DataBaseFun.storedData[0]['userId'],
                                  //     CartDataBaseFun.database);
                                  print(EndPoints.allRecipiesMap['data']['data']
                                      [index]['_id']);
                                  cubit.changeLoveIconState = false;
                                  Navigate(
                                    context: context,
                                    Screen: DetailesScreen(
                                      index: index,
                                      name: EndPoints.allRecipiesMap['data']
                                          ['data'][index]['name'],
                                      imageurl: EndPoints.allRecipiesMap['data']
                                          ['data'][index]['imageCover'],
                                      price: EndPoints.allRecipiesMap['data']
                                          ['data'][index]['price'],
                                      descripthion:
                                          EndPoints.allRecipiesMap['data']
                                              ['data'][index]['category'],
                                      Ingridients:
                                          EndPoints.allRecipiesMap['data']
                                              ['data'][index]['ingredients'],
                                      email: DataBaseFun.storedData[0]['email'],
                                      userId: DataBaseFun.storedData[0]
                                          ['userId'],
                                      recipeId: EndPoints.allRecipiesMap['data']
                                          ['data'][index]['_id'],
                                    ),
                                  );
                                },
                                child: allFoods(
                                  name: EndPoints.allRecipiesMap['data']['data']
                                      [index]['name'],
                                  context: context,
                                  state: state,
                                  index: index,
                                  imageurl: EndPoints.allRecipiesMap['data']
                                      ['data'][index]['imageCover'],
                                  price: EndPoints.allRecipiesMap['data']
                                          ['data'][index]['price']
                                      .toString(),
                                  description: EndPoints.allRecipiesMap['data']
                                      ['data'][index]['category'],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  )
            : Center(
                child: Text('no internet'),
              );
      },
    );
  }
}
