import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/models/bloc/cubits/admin_cubit.dart';
import 'package:resturant/models/bloc/states/admin_state.dart';
import 'package:resturant/models/cach/chach.dart';
import 'package:resturant/models/dio/end_points.dart';
import 'package:resturant/screens/admin_screens/add_recipe_admin.dart';
import 'package:resturant/screens/admin_screens/recipe_detailes_admin.dart';
import 'package:resturant/widgets/navigate.dart';

class RecipesAdmin extends StatelessWidget {
  const RecipesAdmin({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = AdminCubit.get(context);
    String token = CachFunc.getData('token');
    //cubit.getallRecipes();
    return BlocConsumer<AdminCubit, AdminState>(
        builder: (context, state) {
          return Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endDocked,
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: FloatingActionButton(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                  ),
                ),
                backgroundColor: Colors.grey[100],
                child: Icon(
                  Icons.add,
                  color: Colors.orangeAccent,
                ),
                onPressed: () {
                  Navigate(context: context, Screen: AddRecipeAdmin());
                },
              ),
            ),
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 8.0,
                    right: 8,
                    bottom: 25,
                    top: 10,
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigate(
                                    context: context,
                                    Screen: RecipeDetailesAdmin(
                                      imageurl: EndPoints.allrecipesAdmin[index]
                                          ['imageCover'],
                                      cookingTime:
                                          EndPoints.allrecipesAdmin[index]
                                              ['cookingTime'],
                                      price: EndPoints.allrecipesAdmin[index]
                                          ['price'],
                                      ingredients:
                                          EndPoints.allrecipesAdmin[index]
                                              ['ingredients'],
                                      RecipeCategory: EndPoints
                                          .allrecipesAdmin[index]['category'],
                                      Recipeid: EndPoints.allrecipesAdmin[index]
                                          ['_id'],
                                      RecipeName: EndPoints
                                          .allrecipesAdmin[index]['name'],
                                      slug: EndPoints.allrecipesAdmin[index]
                                          ['slug'],
                                    ),
                                  );
                                },
                                child: ListTile(
                                  title: Text(
                                      EndPoints.allrecipesAdmin[index]['name']),
                                  subtitle: Text(EndPoints
                                      .allrecipesAdmin[index]['category']),
                                  leading: CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(EndPoints
                                        .allrecipesAdmin[index]['imageCover']),
                                  ),
                                  trailing: MaterialButton(
                                    onPressed: () {
                                      cubit.deleteRecipe(
                                          token,
                                          EndPoints.allrecipesAdmin[index]
                                              ['_id']);
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.orangeAccent,
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Divider(
                                color: Colors.grey[300],
                                thickness: 1.5,
                              );
                            },
                            itemCount: EndPoints.allrecipesAdmin.length),
                      ),
                      (cubit.noDataRecipe ||
                              EndPoints.allrecipesAdmin.length < 10)
                          ? SizedBox()
                          : state is PageLoading
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : MaterialButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  onPressed: () {
                                    cubit.pageinathionRecipes();
                                  },
                                  color: Colors.orangeAccent,
                                  child: Text(
                                    'load more',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
