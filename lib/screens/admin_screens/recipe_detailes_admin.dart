import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/models/bloc/cubits/admin_cubit.dart';
import 'package:resturant/models/bloc/states/admin_state.dart';
import 'package:resturant/models/cach/chach.dart';

class RecipeDetailesAdmin extends StatelessWidget {
  String RecipeName;
  String Recipeid;
  String imageurl;
  String RecipeCategory;
  num price;
  num cookingTime;
  String slug;
  List ingredients;
  RecipeDetailesAdmin(
      {this.RecipeName,
      this.imageurl,
      this.slug,
      this.price,
      this.cookingTime,
      this.ingredients,
      this.RecipeCategory,
      this.Recipeid});

  @override
  Widget build(BuildContext context) {
    List<TextEditingController> controller = [];
    for (int i = 0; i < ingredients.length; i++) {
      controller.add(TextEditingController());
    }
    var cubit = AdminCubit.get(context);
    String token = CachFunc.getData('token');

    return BlocConsumer<AdminCubit, AdminState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.grey[300],
          appBar: AppBar(
            toolbarHeight: 80,
            actions: [
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 20,
                  top: 20,
                  right: 10,
                ),
                child: MaterialButton(
                  onPressed: () {},
                  color: Colors.orangeAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text(
                    'Save Changes',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
            leading: MaterialButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Icon(Icons.arrow_back_ios),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: Text(
              'Detailes',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Batka',
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(imageurl),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          RecipeName,
                          style: TextStyle(
                            fontFamily: 'Batka',
                            fontSize: 18,
                          ),
                        ),
                        MaterialButton(
                          onPressed: () {},
                          child: Icon(Icons.edit),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      color: Colors.grey[300],
                      thickness: 1.5,
                    ),
                    Text(
                      'Ingredients',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontFamily: 'Batka',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 6,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                controller[index].text = ingredients[index];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                    cursorColor: Colors.black,
                                    controller: controller[index],
                                    keyboardType: TextInputType.text,
                                    onChanged: (value) {},
                                    onSubmitted: (val) {},
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                      labelText: 'ingredients',
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                            color: Colors.orangeAccent,
                                          )),
                                      labelStyle:
                                          TextStyle(color: Colors.black),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                            color: Colors.orangeAccent,
                                          )),
                                      disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.orangeAccent,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: ingredients.length,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(
                      color: Colors.grey[300],
                      thickness: 1.5,
                    ),
                    Text(
                      'Price',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontFamily: 'Batka',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          price.toString(),
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            fontFamily: 'Batka',
                          ),
                        ),
                        MaterialButton(
                          onPressed: () {},
                          child: Icon(
                            Icons.edit,
                          ),
                        )
                      ],
                    ),
                    Divider(
                      color: Colors.grey[300],
                      thickness: 1.5,
                    ),
                    Text(
                      'Cooking Time',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontFamily: 'Batka',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          cookingTime.toString(),
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            fontFamily: 'Batka',
                          ),
                        ),
                        MaterialButton(
                          onPressed: () {},
                          child: Icon(
                            Icons.edit,
                          ),
                        )
                      ],
                    ),
                    Divider(
                      color: Colors.grey[300],
                      thickness: 1.5,
                    ),
                    Text(
                      'Category',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontFamily: 'Batka',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          RecipeCategory,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            fontFamily: 'Batka',
                          ),
                        ),
                        MaterialButton(
                          onPressed: () {},
                          child: Icon(
                            Icons.edit,
                          ),
                        )
                      ],
                    ),
                    Divider(
                      color: Colors.grey[300],
                      thickness: 1.5,
                    ),
                    Text(
                      'Slug',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontFamily: 'Batka',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          slug,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            fontFamily: 'Batka',
                          ),
                        ),
                        MaterialButton(
                          onPressed: () {},
                          child: Icon(
                            Icons.edit,
                          ),
                        )
                      ],
                    ),
                    Divider(
                      color: Colors.grey[300],
                      thickness: 1.5,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
