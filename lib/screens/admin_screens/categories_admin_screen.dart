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
    refresh() {
      return cubit.getAllCategories();
    }

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
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                backgroundColor: Colors.grey[100],
                child: Icon(
                  Icons.add,
                  color: Colors.orangeAccent,
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
                                style: TextStyle(
                                    fontSize: 18, fontFamily: 'Bakta'),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.12,
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
                                  cubit.createNewCategory(
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
            ),
            backgroundColor: Colors.transparent,
            body: RefreshIndicator(
              onRefresh: refresh,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(children: [
                    EndPoints.allCategories == null
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Container(
                            width: MediaQuery.of(context).size.width,
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: EndPoints.allCategories.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    categorieNewName.clear();
                                    showBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return Container(
                                            padding: EdgeInsets.only(
                                              top: 12,
                                              right: 12,
                                              left: 12,
                                            ),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.7,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(25),
                                                  topRight: Radius.circular(25),
                                                ),
                                                color: Colors.white),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
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
                                                      0.08,
                                                ),
                                                TextField(
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                  cursorColor: Colors.black,
                                                  controller: categorieNewName,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  onChanged: (value) {},
                                                  onSubmitted: (val) {},
                                                  decoration: InputDecoration(
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      borderSide: BorderSide(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    labelText:
                                                        'Categorie New Name',
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                            borderSide:
                                                                BorderSide(
                                                              color: Colors
                                                                  .orangeAccent,
                                                            )),
                                                    labelStyle: TextStyle(
                                                        color: Colors.black),
                                                    prefixIcon: Icon(
                                                      IconlyBroken.paper,
                                                      color: Colors.black,
                                                    ),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        borderSide: BorderSide(
                                                          color: Colors
                                                              .orangeAccent,
                                                        )),
                                                    disabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Colors.orangeAccent,
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
                                                        BorderRadius.circular(
                                                            25),
                                                  ),
                                                  color: Colors.orangeAccent,
                                                  onPressed: () {
                                                    cubit.editCategorieName(
                                                      categorieNewName.text,
                                                      token,
                                                      EndPoints.allCategories[
                                                          index]['_id'],
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
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                title: Text(
                                                  'You sure to delete this category',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.black,
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
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Text('Cancel'),
                                                      ),
                                                      MaterialButton(
                                                        onPressed: () {
                                                          cubit.deleteCategorie(
                                                              token,
                                                              EndPoints.allCategories[
                                                                      index]
                                                                  ['_id']);
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Text('Confirm'),
                                                      ),
                                                    ]),
                                              );
                                            });
                                      },
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return Divider(
                                  color: Colors.grey[300],
                                  thickness: 1.5,
                                );
                              },
                            ),
                          )
                  ]),
                ),
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
