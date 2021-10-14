import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:resturant/models/bloc/cubits/admin_cubit.dart';
import 'package:resturant/models/bloc/states/admin_state.dart';
import 'package:resturant/models/cach/chach.dart';
import 'package:resturant/models/dio/end_points.dart';

class UsersAdmin extends StatelessWidget {
  const UsersAdmin({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameBottomSheet = TextEditingController();
    TextEditingController emailBottomSheet = TextEditingController();
    TextEditingController roleBottomSheet = TextEditingController();
    var cubit = AdminCubit.get(context);
    String token = CachFunc.getData('token');
    refresh() {
      cubit.pageUsrs = 2;
      return cubit.getAllusers(token);
    }

    return BlocConsumer<AdminCubit, AdminState>(
        builder: (context, state) {
          return EndPoints.allUser.isEmpty
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
                            'NO Users to show',
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
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: EndPoints.allUser.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                        isScrollControlled: true,
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        context: context,
                                        builder: (context) {
                                          return SingleChildScrollView(
                                            padding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context)
                                                    .viewInsets
                                                    .bottom),
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.7,
                                              decoration: BoxDecoration(
                                                color: EndPoints.isDark
                                                    ? Color(0xff393E46)
                                                    : Colors.white,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(25),
                                                  topRight: Radius.circular(25),
                                                ),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Update ${EndPoints.allUser[index]['name']} profile data (:',
                                                    style: TextStyle(
                                                      color: EndPoints.isDark
                                                          ? Colors.white
                                                          : EndPoints.isDark
                                                              ? Colors.white
                                                              : Colors.black,
                                                      fontSize: 18,
                                                      fontFamily: 'Bakta',
                                                      fontWeight:
                                                          FontWeight.w900,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    child: TextField(
                                                      style: TextStyle(
                                                        color: EndPoints.isDark
                                                            ? Colors.white
                                                            : EndPoints.isDark
                                                                ? Colors.white
                                                                : Colors.black,
                                                      ),
                                                      cursorColor: EndPoints
                                                              .isDark
                                                          ? Colors.white
                                                          : EndPoints.isDark
                                                              ? Colors.white
                                                              : Colors.black,
                                                      controller:
                                                          usernameBottomSheet,
                                                      keyboardType:
                                                          TextInputType.text,
                                                      onChanged: (value) {},
                                                      onSubmitted: (val) {},
                                                      decoration:
                                                          InputDecoration(
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors
                                                                  .orangeAccent),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                        ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          borderSide:
                                                              BorderSide(
                                                            color: EndPoints
                                                                    .isDark
                                                                ? Colors.white
                                                                : EndPoints
                                                                        .isDark
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .black,
                                                          ),
                                                        ),
                                                        labelText: 'UserName',
                                                        labelStyle: TextStyle(
                                                            color: EndPoints
                                                                    .isDark
                                                                ? Colors.white
                                                                : EndPoints
                                                                        .isDark
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .black),
                                                        prefixIcon: Icon(
                                                          IconlyBroken.profile,
                                                          color: EndPoints
                                                                  .isDark
                                                              ? Colors.white
                                                              : EndPoints.isDark
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                        ),
                                                        border:
                                                            OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                          color: EndPoints
                                                                  .isDark
                                                              ? Colors.white
                                                              : EndPoints.isDark
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                        )),
                                                        disabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: EndPoints
                                                                    .isDark
                                                                ? Colors.white
                                                                : EndPoints
                                                                        .isDark
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .black,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    child: TextField(
                                                      style: TextStyle(
                                                        color: EndPoints.isDark
                                                            ? Colors.white
                                                            : EndPoints.isDark
                                                                ? Colors.white
                                                                : Colors.black,
                                                      ),
                                                      cursorColor: EndPoints
                                                              .isDark
                                                          ? Colors.white
                                                          : EndPoints.isDark
                                                              ? Colors.white
                                                              : Colors.black,
                                                      controller:
                                                          emailBottomSheet,
                                                      keyboardType:
                                                          TextInputType
                                                              .emailAddress,
                                                      onChanged: (value) {},
                                                      onSubmitted: (val) {},
                                                      decoration:
                                                          InputDecoration(
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors
                                                                  .orangeAccent),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                        ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          borderSide:
                                                              BorderSide(
                                                            color: EndPoints
                                                                    .isDark
                                                                ? Colors.white
                                                                : EndPoints
                                                                        .isDark
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .black,
                                                          ),
                                                        ),
                                                        labelText: 'Email',
                                                        labelStyle: TextStyle(
                                                            color: EndPoints
                                                                    .isDark
                                                                ? Colors.white
                                                                : EndPoints
                                                                        .isDark
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .black),
                                                        prefixIcon: Icon(
                                                          Icons.email,
                                                          color: EndPoints
                                                                  .isDark
                                                              ? Colors.white
                                                              : EndPoints.isDark
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                        ),
                                                        border:
                                                            OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                          color: EndPoints
                                                                  .isDark
                                                              ? Colors.white
                                                              : EndPoints.isDark
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                        )),
                                                        disabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: EndPoints
                                                                    .isDark
                                                                ? Colors.white
                                                                : EndPoints
                                                                        .isDark
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .black,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    child: TextField(
                                                      style: TextStyle(
                                                        color: EndPoints.isDark
                                                            ? Colors.white
                                                            : EndPoints.isDark
                                                                ? Colors.white
                                                                : Colors.black,
                                                      ),
                                                      cursorColor: EndPoints
                                                              .isDark
                                                          ? Colors.white
                                                          : EndPoints.isDark
                                                              ? Colors.white
                                                              : Colors.black,
                                                      controller:
                                                          roleBottomSheet,
                                                      keyboardType:
                                                          TextInputType.text,
                                                      onChanged: (value) {},
                                                      onSubmitted: (val) {},
                                                      decoration:
                                                          InputDecoration(
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors
                                                                  .orangeAccent),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                        ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          borderSide:
                                                              BorderSide(
                                                            color: EndPoints
                                                                    .isDark
                                                                ? Colors.white
                                                                : EndPoints
                                                                        .isDark
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .black,
                                                          ),
                                                        ),
                                                        labelText: 'role',
                                                        labelStyle: TextStyle(
                                                            color: EndPoints
                                                                    .isDark
                                                                ? Colors.white
                                                                : EndPoints
                                                                        .isDark
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .black),
                                                        prefixIcon: Icon(
                                                          Icons.person,
                                                          color: EndPoints
                                                                  .isDark
                                                              ? Colors.white
                                                              : EndPoints.isDark
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                        ),
                                                        border:
                                                            OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                          color: EndPoints
                                                                  .isDark
                                                              ? Colors.white
                                                              : EndPoints.isDark
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                        )),
                                                        disabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: EndPoints
                                                                    .isDark
                                                                ? Colors.white
                                                                : EndPoints
                                                                        .isDark
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .black,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 250,
                                                    height: 50,
                                                    child: MaterialButton(
                                                      onPressed: () {
                                                        print(EndPoints
                                                                .allUser[index]
                                                            ['_id']);
                                                        cubit.updateuser(
                                                          token,
                                                          EndPoints.allUser[
                                                              index]['_id'],
                                                          usernameBottomSheet
                                                                  .text
                                                                  .trim()
                                                                  .isEmpty
                                                              ? EndPoints
                                                                      .allUser[
                                                                  index]['name']
                                                              : usernameBottomSheet
                                                                  .text
                                                                  .trim(),
                                                          emailBottomSheet.text
                                                                  .trim()
                                                                  .isEmpty
                                                              ? EndPoints.allUser[
                                                                      index]
                                                                  ['email']
                                                              : emailBottomSheet
                                                                  .text
                                                                  .trim(),
                                                          context,
                                                          roleBottomSheet.text
                                                                  .trim()
                                                                  .isEmpty
                                                              ? 'user'
                                                              : roleBottomSheet
                                                                  .text
                                                                  .trim(),
                                                        );
                                                        // cubit
                                                        //     .updateUserDataBase(
                                                        //   token: token,
                                                        //   name: usernameBottomSheet
                                                        //           .text
                                                        //           .trim()
                                                        //           .isEmpty
                                                        //       ? EndPoints
                                                        //               .allUser[
                                                        //           index]['name']
                                                        //       : usernameBottomSheet
                                                        //           .text
                                                        //           .trim(),
                                                        //   email: emailBottomSheet
                                                        //           .text
                                                        //           .trim()
                                                        //           .isEmpty
                                                        //       ? EndPoints.allUser[
                                                        //               index]
                                                        //           ['email']
                                                        //       : emailBottomSheet
                                                        //           .text
                                                        //           .trim(),
                                                        //   context: context,
                                                        // );
                                                      },
                                                      child: Text(
                                                        'Update',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                          fontFamily: 'Bakta',
                                                          fontWeight:
                                                              FontWeight.w900,
                                                        ),
                                                      ),
                                                      color:
                                                          Colors.orangeAccent,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  child: ListTile(
                                    horizontalTitleGap: 15,
                                    leading: CircleAvatar(
                                      radius: 20,
                                      backgroundImage: NetworkImage(
                                          '${EndPoints.allUser[index]['photo']}'),
                                    ),
                                    title: Text(
                                      '${EndPoints.allUser[index]['name']}',
                                      style: TextStyle(
                                        color: EndPoints.isDark
                                            ? Colors.white
                                            : EndPoints.isDark
                                                ? Colors.white
                                                : Colors.black,
                                      ),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${EndPoints.allUser[index]['email']}',
                                          style: TextStyle(
                                            color: EndPoints.isDark
                                                ? Colors.white
                                                : EndPoints.isDark
                                                    ? Colors.white
                                                    : Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          '${EndPoints.allUser[index]['role']}',
                                          style: TextStyle(
                                            color: EndPoints.isDark
                                                ? Colors.white
                                                : EndPoints.isDark
                                                    ? Colors.white
                                                    : Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    trailing: MaterialButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                backgroundColor:
                                                    EndPoints.isDark
                                                        ? Color(0xff393E46)
                                                        : Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                title: Text(
                                                  'You sure to delete this user',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: EndPoints.isDark
                                                        ? Colors.white
                                                        : EndPoints.isDark
                                                            ? Colors.white
                                                            : Colors.black,
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
                                                        child: Text(
                                                          'Cancel',
                                                          style: TextStyle(
                                                            color: EndPoints
                                                                    .isDark
                                                                ? Colors.white
                                                                : EndPoints
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
                                                          cubit.deleteUserById(
                                                              token,
                                                              EndPoints.allUser[
                                                                      index]
                                                                  ['_id']);
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Text(
                                                          'Confirm',
                                                          style: TextStyle(
                                                            color: EndPoints
                                                                    .isDark
                                                                ? Colors.white
                                                                : EndPoints
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
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return Divider(
                                  color: EndPoints.isDark
                                      ? Color(0xff222831)
                                      : Colors.grey[200],
                                  thickness: 1.5,
                                );
                              },
                            ),
                          ),
                          (cubit.noDataUsers || EndPoints.allUser.length < 10)
                              ? SizedBox()
                              : state is PageLoading
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : MaterialButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      color: Colors.orangeAccent,
                                      onPressed: () {
                                        cubit.pageinathionusers(token);
                                      },
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
                );
        },
        listener: (context, state) {});
  }
}
