import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:resturant/models/bloc/cubits/admin_cubit.dart';
import 'package:resturant/models/bloc/states/admin_state.dart';
import 'package:resturant/models/cach/chach.dart';
import 'package:resturant/models/dio/end_points.dart';

class CategoriesAdmin extends StatelessWidget {
  const CategoriesAdmin({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController categorieName = TextEditingController();
    TextEditingController categorieNewName = TextEditingController();
    String token = CachFunc.getData('token');
    var cubit = AdminCubit.get(context);
    //cubit.getAllCategories();
    return BlocConsumer<AdminCubit, AdminState>(
        builder: (context, state) {
          return Scaffold(
            floatingActionButton: MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              color: Colors.orangeAccent,
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                showBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        padding: EdgeInsets.all(12),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.5,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                            ),
                            color: Colors.white),
                        child: Column(
                          children: [
                            Text(
                              'Create new Categorie',
                              style:
                                  TextStyle(fontSize: 18, fontFamily: 'Bakta'),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.12,
                            ),
                            TextField(
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              cursorColor: Colors.black,
                              controller: categorieName,
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
                                labelText: 'Categorie Name',
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                      color: Colors.orangeAccent,
                                    )),
                                labelStyle: TextStyle(color: Colors.black),
                                prefixIcon: Icon(
                                  IconlyBroken.paper,
                                  color: Colors.black,
                                ),
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
                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              color: Colors.orangeAccent,
                              onPressed: () {
                                cubit.createNewRecipe(
                                    token, categorieName.text, context);
                              },
                              child: Text(
                                'Add',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      );
                    });
              },
            ),
            backgroundColor: Colors.transparent,
            body: Column(children: [
              EndPoints.allCategories == []
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: EndPoints.allCategories.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              categorieNewName.clear();
                              showBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      padding: EdgeInsets.all(12),
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.5,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(25),
                                            topRight: Radius.circular(25),
                                          ),
                                          color: Colors.white),
                                      child: Column(
                                        children: [
                                          Text(
                                            'Update Categorie Name',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'Bakta'),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.12,
                                          ),
                                          TextField(
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                            cursorColor: Colors.black,
                                            controller: categorieNewName,
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
                                              labelText: 'Categorie New Name',
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  borderSide: BorderSide(
                                                    color: Colors.orangeAccent,
                                                  )),
                                              labelStyle: TextStyle(
                                                  color: Colors.black),
                                              prefixIcon: Icon(
                                                IconlyBroken.paper,
                                                color: Colors.black,
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  borderSide: BorderSide(
                                                    color: Colors.orangeAccent,
                                                  )),
                                              disabledBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.orangeAccent,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          MaterialButton(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                            ),
                                            color: Colors.orangeAccent,
                                            onPressed: () {
                                              cubit.editCategorieName(
                                                categorieNewName.text,
                                                token,
                                                EndPoints.allCategories[index]
                                                    ['_id'],
                                                context,
                                              );
                                            },
                                            child: Text(
                                              'Change',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  });
                            },
                            child: ListTile(
                              title: Text(
                                EndPoints.allCategories[index]['name'],
                                style: TextStyle(
                                  fontFamily: 'Bakta',
                                  fontSize: 18,
                                ),
                              ),
                              trailing: MaterialButton(
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.orangeAccent,
                                ),
                                onPressed: () {
                                  cubit.deleteCategorie(token,
                                      EndPoints.allCategories[index]['_id']);
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    )
            ]),
          );
        },
        listener: (context, state) {});
  }
}
