import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/models/bloc/cubits/admin_cubit.dart';
import 'package:resturant/models/bloc/states/admin_state.dart';
import 'package:resturant/models/cach/chach.dart';
import 'package:resturant/models/dio/end_points.dart';
import 'package:resturant/screens/admin_screens/add_recipe_admin.dart';
import 'package:resturant/screens/admin_screens/recipe_detailes_admin.dart';
import 'package:resturant/screens/user_screens/picture_screen.dart';
import 'package:resturant/widgets/navigate.dart';

class RecipesAdmin extends StatelessWidget {
  const RecipesAdmin({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = AdminCubit.get(context);
    String token = CachFunc.getData('token');
    //cubit.getallRecipes();
    refresh() {
      cubit.pageRecipe = 2;
      return cubit.getallRecipes();
    }

    return BlocConsumer<AdminCubit, AdminState>(
        builder: (context, state) {
          return Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endDocked,
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: FloatingActionButton(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    topLeft: Radius.circular(25),
                  ),
                ),
                backgroundColor:
                    EndPoints.isDark ? Color(0xff393E46) : Colors.grey[100],
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
            body: EndPoints.allrecipesAdmin.isEmpty
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
                                    : EndPoints.isDark
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
                      child: Card(
                        color:
                            EndPoints.isDark ? Color(0xff393E46) : Colors.white,
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
                                              imageurl: EndPoints
                                                      .allrecipesAdmin[index]
                                                  ['imageCover'],
                                              cookingTime: EndPoints
                                                      .allrecipesAdmin[index]
                                                  ['cookingTime'],
                                              price: EndPoints
                                                      .allrecipesAdmin[index]
                                                  ['price'],
                                              ingredients: EndPoints
                                                      .allrecipesAdmin[index]
                                                  ['ingredients'],
                                              RecipeCategory: EndPoints
                                                      .allrecipesAdmin[index]
                                                  ['category'],
                                              Recipeid: EndPoints
                                                      .allrecipesAdmin[index]
                                                  ['_id'],
                                              RecipeName: EndPoints
                                                      .allrecipesAdmin[index]
                                                  ['name'],
                                              slug: EndPoints
                                                      .allrecipesAdmin[index]
                                                  ['slug'],
                                            ),
                                          );
                                        },
                                        child: ListTile(
                                          title: Text(
                                            EndPoints.allrecipesAdmin[index]
                                                ['name'],
                                            style: TextStyle(
                                              color: EndPoints.isDark
                                                  ? Colors.white
                                                  : EndPoints.isDark
                                                      ? Colors.white
                                                      : Colors.black,
                                            ),
                                          ),
                                          subtitle: Text(
                                            EndPoints.allrecipesAdmin[index]
                                                ['category'],
                                            style: TextStyle(
                                              color: EndPoints.isDark
                                                  ? Colors.white
                                                  : EndPoints.isDark
                                                      ? Colors.white
                                                      : Colors.black,
                                            ),
                                          ),
                                          leading: InkWell(
                                            customBorder:
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            onTap: () {
                                              Navigate(
                                                  Screen: PictureScreen(
                                                    imageUrl: EndPoints
                                                            .allrecipesAdmin[
                                                        index]['imageCover'],
                                                    recipeName: EndPoints
                                                            .allrecipesAdmin[
                                                        index]['name'],
                                                    index: index,
                                                  ),
                                                  context: context);
                                            },
                                            child: Hero(
                                              tag: index.toString(),
                                              child: CircleAvatar(
                                                radius: 30,
                                                backgroundImage: NetworkImage(
                                                    EndPoints.allrecipesAdmin[
                                                        index]['imageCover']),
                                              ),
                                            ),
                                          ),
                                          trailing: MaterialButton(
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      backgroundColor: EndPoints
                                                              .isDark
                                                          ? Color(0xff393E46)
                                                          : Colors.white,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                      title: Text(
                                                        'You sure to delete this recipe',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color: EndPoints
                                                                  .isDark
                                                              ? Colors.white
                                                              : EndPoints.isDark
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                          fontFamily: 'Bakta',
                                                        ),
                                                      ),
                                                      content: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            MaterialButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: Text(
                                                                'Cancel',
                                                                style:
                                                                    TextStyle(
                                                                  color: EndPoints
                                                                          .isDark
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black,
                                                                ),
                                                              ),
                                                            ),
                                                            MaterialButton(
                                                              onPressed: () {
                                                                cubit.deleteRecipe(
                                                                    token,
                                                                    EndPoints.allrecipesAdmin[
                                                                            index]
                                                                        [
                                                                        '_id']);
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: Text(
                                                                'Confirm',
                                                                style:
                                                                    TextStyle(
                                                                  color: EndPoints
                                                                          .isDark
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black,
                                                                ),
                                                              ),
                                                            ),
                                                          ]),
                                                    );
                                                  });
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
                                        color: EndPoints.isDark
                                            ? Color(0xff222831)
                                            : Colors.grey[200],
                                        thickness: 1.5,
                                      );
                                    },
                                    itemCount:
                                        EndPoints.allrecipesAdmin.length),
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
                                            borderRadius:
                                                BorderRadius.circular(25),
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
                  ),
          );
        },
        listener: (context, state) {});
  }
}
