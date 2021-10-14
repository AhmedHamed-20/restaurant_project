import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/components/popular_widget.dart';
import 'package:resturant/models/bloc/cubits/cubit.dart';
import 'package:resturant/models/bloc/states/states.dart';
import 'package:resturant/models/databasae/database.dart';
import 'package:resturant/models/dio/end_points.dart';
import 'package:resturant/screens/user_screens/detailes_screen.dart';
import 'package:resturant/widgets/all_fodods.dart';
import 'package:resturant/widgets/navigate.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = Appcubit.get(context);
    refresh() {
      return cubit.getallRecipes();
    }

    return BlocConsumer<Appcubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        cubit.checkConnecthion();
        return cubit.result
            ? EndPoints.allRecipiesMap.isEmpty
                ? RefreshIndicator(
                    onRefresh: refresh,
                    child: SingleChildScrollView(
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'NO Recipes to show',
                              style: TextStyle(
                                color: EndPoints.isDark
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 18,
                                fontFamily: 'Batka',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: refresh,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15, bottom: 10, top: 10),
                            child: Text(
                              'Popular Foods',
                              style: TextStyle(
                                color: EndPoints.isDark
                                    ? Colors.white
                                    : Colors.grey[800],
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
                            padding:
                                const EdgeInsets.only(left: 15, bottom: 10),
                            child: Text(
                              'All Recipes',
                              style: TextStyle(
                                color: EndPoints.isDark
                                    ? Colors.white
                                    : Colors.grey[800],
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
                              itemCount: EndPoints.recipes.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    // cubit.getbyuseridandFavorite(
                                    //     DataBaseFun.storedData[0]['userId'],
                                    //     CartDataBaseFun.database);
                                    print(EndPoints.allRecipiesMap['data']
                                        ['data'][index]['_id']);
                                    cubit.changeLoveIconState = false;
                                    Navigate(
                                      context: context,
                                      Screen: DetailesScreen(
                                        index: index,
                                        name: EndPoints.recipes[index]['name'],
                                        imageurl: EndPoints.recipes[index]
                                            ['imageCover'],
                                        price: EndPoints.recipes[index]
                                            ['price'],
                                        descripthion: EndPoints.recipes[index]
                                            ['category'],
                                        Ingridients: EndPoints.recipes[index]
                                            ['ingredients'],
                                        email: DataBaseFun.storedData[0]
                                            ['email'],
                                        userId: DataBaseFun.storedData[0]
                                            ['userId'],
                                        recipeId: EndPoints.recipes[index]
                                            ['_id'],
                                      ),
                                    );
                                  },
                                  child: allFoods(
                                    name: EndPoints.recipes[index]['name'],
                                    context: context,
                                    state: state,
                                    index: index,
                                    imageurl: EndPoints.recipes[index]
                                        ['imageCover'],
                                    price: EndPoints.recipes[index]['price']
                                        .toString(),
                                    description: EndPoints.recipes[index]
                                        ['category'],
                                  ),
                                );
                              },
                            ),
                          ),
                          Center(
                            child: state is PageLoading
                                ? CircularProgressIndicator()
                                : cubit.noData
                                    ? SizedBox()
                                    : MaterialButton(
                                        color: Colors.orangeAccent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        onPressed: () {
                                          cubit.pageinathion();
                                        },
                                        child: Text(
                                          'Load more',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                          )
                        ],
                      ),
                    ),
                  )
            : Center(
                child: Text('no internet'),
              );
      },
    );
  }
}
