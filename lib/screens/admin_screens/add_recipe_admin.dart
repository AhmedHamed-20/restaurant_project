import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:resturant/models/bloc/cubits/admin_cubit.dart';
import 'package:resturant/models/bloc/states/admin_state.dart';
import 'package:resturant/models/cach/chach.dart';

class AddRecipeAdmin extends StatelessWidget {
  const AddRecipeAdmin({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController recipeNameController = TextEditingController();
    TextEditingController recipePriceController = TextEditingController();

    TextEditingController recipeCockingController = TextEditingController();
    TextEditingController recipeCategoryController = TextEditingController();
    TextEditingController recipeSlugController = TextEditingController();

    return BlocConsumer<AdminCubit, AdminState>(
        builder: (context, state) {
          var cubit = AdminCubit.get(context);

          for (int i = 0; i < cubit.lengthOFtextfield; i++) {
            cubit.controller.add(TextEditingController());
          }

          String token = CachFunc.getData('token');
          int value = 1;
          List ingredients = [];
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
                    onPressed: () {
                      ingredients.clear();
                      for (int i = 0; i < cubit.controller.length; i++) {
                        if (cubit.controller[i].text != '') {
                          ingredients.add(cubit.controller[i].text);
                        }
                      }
                      if (cubit.AddImagePicked == null ||
                          recipeNameController.text.trim() == null ||
                          ingredients == null ||
                          int.parse(recipePriceController.text) == null ||
                          int.parse(recipeCockingController.text) == null ||
                          recipeSlugController.text.trim() == null ||
                          recipeCategoryController.text.trim() == null) {
                        Fluttertoast.showToast(
                            msg: 'Please make sure to fill all data',
                            textColor: Colors.white,
                            backgroundColor: Colors.red);
                      } else {
                        print(ingredients);
                        print(recipeNameController.text.trim());
                        print(recipeCategoryController.text.trim());
                        cubit.addRecipe(
                            name: recipeNameController.text.trim(),
                            ingredient: ingredients,
                            price: int.parse(recipePriceController.text),
                            cockingtime:
                                int.parse(recipeCockingController.text),
                            slug: recipeSlugController.text.trim(),
                            category: recipeCategoryController.text.trim(),
                            token: token,
                            image: cubit.AddImagePicked,
                            context: context);
                      }
                    },
                    color: Colors.orangeAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text(
                      'Create',
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
                  cubit.lengthOFtextfield = 5;
                  cubit.AddImagePicked = null;
                  for (int i = 0; i < cubit.controller.length; i++) {
                    cubit.controller[i].clear();
                  }
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
            body: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: InkWell(
                          onTap: () {
                            cubit.Addimagepick();
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.orange[200],
                            radius: 50,
                            backgroundImage: cubit.AddImagePicked == null
                                ? AssetImage(
                                    'assets/images/add.png',
                                  )
                                : FileImage(cubit.AddImagePicked),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: Colors.grey[300],
                        thickness: 1.5,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Name',
                        style: TextStyle(
                          fontFamily: 'Batka',
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        cursorColor: Colors.black,
                        controller: recipeNameController,
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
                          labelText: 'Name',
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Colors.orangeAccent,
                              )),
                          labelStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
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
                      Divider(
                        color: Colors.grey[300],
                        thickness: 1.5,
                      ),
                      Text(
                        'Ingredients',
                        style: TextStyle(
                          fontFamily: 'Batka',
                          fontSize: 24,
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
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                          cursorColor: Colors.black,
                                          controller: cubit.controller[index],
                                          keyboardType: TextInputType.text,
                                          onChanged: (value) {},
                                          onSubmitted: (val) {},
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
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
                                      ),
                                      MaterialButton(
                                        onPressed: () {
                                          cubit.decrementTextfieldNumber(
                                              cubit.controller, index);
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.orangeAccent,
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                              itemCount: cubit.lengthOFtextfield,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: MaterialButton(
                          color: Colors.orangeAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          onPressed: () {
                            cubit.incrementTextfieldNumber(cubit.controller);
                          },
                          child: Text(
                            'Add More TextField',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Price',
                        style: TextStyle(
                          fontFamily: 'Batka',
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        cursorColor: Colors.black,
                        controller: recipePriceController,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {},
                        onSubmitted: (val) {},
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          labelText: 'Price',
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Colors.orangeAccent,
                              )),
                          labelStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
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
                      Divider(
                        color: Colors.grey[300],
                        thickness: 1.5,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Category',
                        style: TextStyle(
                          fontFamily: 'Batka',
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        cursorColor: Colors.black,
                        controller: recipeCategoryController,
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
                          labelText: 'Category',
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Colors.orangeAccent,
                              )),
                          labelStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
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
                      Divider(
                        color: Colors.grey[300],
                        thickness: 1.5,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Cocking Time',
                        style: TextStyle(
                          fontFamily: 'Batka',
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        cursorColor: Colors.black,
                        controller: recipeCockingController,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {},
                        onSubmitted: (val) {},
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          labelText: 'Cocking Time',
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Colors.orangeAccent,
                              )),
                          labelStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
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
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: Colors.grey[300],
                        thickness: 1.5,
                      ),
                      Text(
                        'Slug',
                        style: TextStyle(
                          fontFamily: 'Batka',
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        cursorColor: Colors.black,
                        controller: recipeSlugController,
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
                          labelText: 'Slug',
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Colors.orangeAccent,
                              )),
                          labelStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
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
                    ],
                  ),
                ),
              ),
            ),
          );
          ;
        },
        listener: (context, state) {});
  }
}
