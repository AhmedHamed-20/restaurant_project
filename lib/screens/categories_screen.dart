import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/models/bloc/cubits/cubit.dart';
import 'package:resturant/models/bloc/states/states.dart';
import 'package:resturant/models/dio/dio.dart';
import 'package:resturant/models/dio/end_points.dart';
import 'package:resturant/screens/categorie_detailes.dart';
import 'package:resturant/widgets/navigate.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Appcubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = Appcubit.get(context);
          cubit.checkConnecthion();
          //      cubit.getGetogries();
          return cubit.result
              ? EndPoints.allCategoriesMap == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : GridView.builder(
                      itemCount: EndPoints.allCategoriesMap['results'],
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            DioFunc.getdate(
                              url: EndPoints.getCategoryRecipe +
                                  EndPoints.allCategoriesMap['data']['data']
                                      [index]['name'],
                            ).then(
                              (value) {
                                print(value);
                                Navigate(
                                    context: context,
                                    Screen: CategoriesDetailes(
                                      Data: value.data,
                                    ));
                              },
                            );
                          },
                          child: Card(
                            margin: EdgeInsets.all(8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Center(
                                child: Text(
                                  '${EndPoints.allCategoriesMap['data']['data'][index]['name']}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Batka',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 150,
                      ),
                    )
              : Center(
                  child: Text('No internet'),
                );
        });
  }
}
