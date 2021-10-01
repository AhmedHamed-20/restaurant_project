import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/models/bloc/cubits/admin_cubit.dart';
import 'package:resturant/models/bloc/states/admin_state.dart';
import 'package:resturant/models/cach/chach.dart';

List<TextEditingController> controller = [];
TextEditingController recipeNameController = TextEditingController();
TextEditingController recipePriceController = TextEditingController();

TextEditingController recipeCockingController = TextEditingController();
TextEditingController recipeCategoryController = TextEditingController();
TextEditingController recipeSlugController = TextEditingController();

List editIngredients = [];

class RecipeDetailesAdmin extends StatefulWidget {
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
  State<RecipeDetailesAdmin> createState() => _RecipeDetailesAdminState();
}

class _RecipeDetailesAdminState extends State<RecipeDetailesAdmin> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = AdminCubit.get(context);
    String token = CachFunc.getData('token');
    List<TextEditingController> controller = [];
    TextEditingController recipeNameController = TextEditingController();
    TextEditingController recipePriceController = TextEditingController();

    TextEditingController recipeCockingController = TextEditingController();
    TextEditingController recipeCategoryController = TextEditingController();
    TextEditingController recipeSlugController = TextEditingController();
    for (int i = 0; i < widget.ingredients.length; i++) {
      controller.add(TextEditingController());
      controller[i].text = widget.ingredients[i];
    }
    recipeNameController.text = widget.RecipeName;
    recipePriceController.text = widget.price.toString();
    recipeCockingController.text = widget.cookingTime.toString();
    recipeCategoryController.text = widget.RecipeCategory;
    recipeSlugController.text = widget.slug;
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
                  onPressed: () {
                    editIngredients.clear();
                    for (int i = 0; i < widget.ingredients.length; i++) {
                      print(controller[i].text);
                      if (controller[i].text != '') {
                        editIngredients.add(controller[i].text.trim());
                      }
                    }
                    if (cubit.imagepicked == null) {
                      cubit.editRecipeWithoutPhoto(
                          widget.Recipeid,
                          token,
                          recipeNameController.text,
                          recipeSlugController.text,
                          editIngredients,
                          recipeCategoryController.text,
                          int.parse(recipeCockingController.text),
                          int.parse(recipePriceController.text),
                          context);
                    } else {
                      cubit.editRecipeData(
                          token,
                          recipeNameController.text,
                          recipeSlugController.text,
                          int.parse(recipePriceController.text),
                          int.parse(recipeCockingController.text),
                          editIngredients,
                          widget.Recipeid,
                          cubit.imagepicked,
                          context);
                    }
                  },
                  color: Colors.orangeAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: state is UploadState
                      ? CircularProgressIndicator(
                          strokeWidth: 1.6,
                        )
                      : Text(
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
                cubit.imagepicked = null;
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
                      child: InkWell(
                        onTap: () {
                          cubit.pickimage();
                        },
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: cubit.imagepicked == null
                              ? NetworkImage(widget.imageurl)
                              : FileImage(cubit.imagepicked),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
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
                              itemCount: widget.ingredients.length,
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
                    TextField(
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      cursorColor: Colors.black,
                      controller: recipePriceController,
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
                    TextField(
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      cursorColor: Colors.black,
                      controller: recipeCockingController,
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
                        labelText: 'Cooking Time',
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
