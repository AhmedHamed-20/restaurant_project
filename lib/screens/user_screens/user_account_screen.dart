import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:resturant/models/bloc/cubits/cubit.dart';
import 'package:resturant/models/bloc/states/states.dart';
import 'package:resturant/models/cach/chach.dart';
import 'package:resturant/models/databasae/database.dart';
import 'package:resturant/models/dio/end_points.dart';

class UserAccount extends StatefulWidget {
  @override
  State<UserAccount> createState() => _UserAccountState();
}

class _UserAccountState extends State<UserAccount> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailcontroller = TextEditingController();
    TextEditingController userName = TextEditingController();
    TextEditingController emailBottomSheet = TextEditingController();

    TextEditingController usernameBottomSheet = TextEditingController();
    TextEditingController currentpassword = TextEditingController();
    TextEditingController newPassword = TextEditingController();
    TextEditingController confirmpassword = TextEditingController();
    final scaffoldState = GlobalKey<ScaffoldState>();
    return BlocConsumer<Appcubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        String isAdmin = CachFunc.getData('isAdmin');
        emailcontroller.text = DataBaseFun.storedData.isEmpty
            ? ''
            : DataBaseFun.storedData[0]['email'];
        userName.text = DataBaseFun.storedData.isEmpty
            ? ''
            : DataBaseFun.storedData[0]['name'];
        var cubit = Appcubit.get(context);
        cubit.checkConnecthion();
        String token = CachFunc.getData('token');
        return Scaffold(
          key: scaffoldState,
          appBar: AppBar(
            leading: MaterialButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Icon(Icons.arrow_back_ios),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              'Account',
              style: TextStyle(
                color: Colors.grey[800],
                fontFamily: 'Batka',
              ),
            ),
            iconTheme: IconThemeData(
              color: Colors.grey[800],
            ),
            centerTitle: true,
          ),
          body: cubit.result
              ? Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Center(
                          child: DataBaseFun.storedData.isEmpty
                              ? CircularProgressIndicator()
                              : CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      DataBaseFun.storedData[0]['photourl']),
                                  radius: 65,
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
                          controller: userName,
                          enabled: false,
                          keyboardType: TextInputType.text,
                          onChanged: (value) {},
                          onSubmitted: (val) {},
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Colors.orangeAccent,
                                )),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            labelText: 'User Name',
                            labelStyle: TextStyle(color: Colors.black),
                            prefixIcon: Icon(
                              IconlyBroken.profile,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                )),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
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
                          controller: emailcontroller,
                          enabled: false,
                          keyboardType: TextInputType.text,
                          onChanged: (value) {},
                          onSubmitted: (val) {},
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Colors.orangeAccent,
                                )),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Colors.black),
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                )),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        isAdmin == null
                            ? Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.orangeAccent,
                                ),
                                width: double.infinity,
                                child: MaterialButton(
                                  padding: EdgeInsets.all(12),
                                  onPressed: () {
                                    scaffoldState.currentState.showBottomSheet(
                                      (context) => SingleChildScrollView(
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
                                            color: Colors.grey[100],
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(25),
                                              topRight: Radius.circular(25),
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Update your profile data (:',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontFamily: 'Bakta',
                                                  fontWeight: FontWeight.w900,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(15),
                                                child: TextField(
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                  cursorColor: Colors.black,
                                                  controller:
                                                      usernameBottomSheet,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  onChanged: (value) {},
                                                  onSubmitted: (val) {},
                                                  decoration: InputDecoration(
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors
                                                              .orangeAccent),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      borderSide: BorderSide(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    labelText: 'UserName',
                                                    labelStyle: TextStyle(
                                                        color: Colors.black),
                                                    prefixIcon: Icon(
                                                      IconlyBroken.profile,
                                                      color: Colors.black,
                                                    ),
                                                    border: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                      color: Colors.black,
                                                    )),
                                                    disabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(15),
                                                child: TextField(
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                  cursorColor: Colors.black,
                                                  controller: emailBottomSheet,
                                                  keyboardType: TextInputType
                                                      .emailAddress,
                                                  onChanged: (value) {},
                                                  onSubmitted: (val) {},
                                                  decoration: InputDecoration(
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors
                                                              .orangeAccent),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      borderSide: BorderSide(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    labelText: 'Email',
                                                    labelStyle: TextStyle(
                                                        color: Colors.black),
                                                    prefixIcon: Icon(
                                                      Icons.email,
                                                      color: Colors.black,
                                                    ),
                                                    border: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                      color: Colors.black,
                                                    )),
                                                    disabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.black,
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
                                                    cubit.updateUser(
                                                      name: usernameBottomSheet
                                                              .text
                                                              .trim()
                                                              .isEmpty
                                                          ? DataBaseFun
                                                                  .storedData[0]
                                                              ['name']
                                                          : usernameBottomSheet
                                                              .text,
                                                      email: emailBottomSheet
                                                              .text
                                                              .trim()
                                                              .isEmpty
                                                          ? DataBaseFun
                                                                  .storedData[0]
                                                              ['email']
                                                          : emailBottomSheet
                                                              .text,
                                                      token: token,
                                                      context: context,
                                                    );
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
                                                  color: Colors.orangeAccent,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );

                                    print(userName.text);
                                    print(emailcontroller.text);
                                    print(token);
                                  },
                                  child: Text(
                                    'Update',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontFamily: 'Batka',
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox(),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.orangeAccent,
                          ),
                          width: double.infinity,
                          child: MaterialButton(
                            padding: EdgeInsets.all(12),
                            onPressed: () async {
                              CachFunc.getData('isAdmin') == ''
                                  ? cubit
                                      .logout('token', context)
                                      .then((value) {
                                      if (cubit.IslogedOut) {
                                        cubit.deleteFromDataBase(0, context);
                                        EndPoints.FilteredCartDataBase = [];
                                        cubit.OrdersMap = {};
                                      }
                                    })
                                  : await CachFunc.deleteData('isAdmin')
                                      .then((value) {
                                      cubit
                                          .logout('token', context)
                                          .then((value) {
                                        if (cubit.IslogedOut) {
                                          cubit.deleteFromDataBase(0, context);
                                          EndPoints.FilteredCartDataBase = [];
                                          cubit.OrdersMap = {};
                                        }
                                      });
                                    });
                            },
                            child: Text(
                              'LogOut',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Batka',
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.orangeAccent,
                          ),
                          width: double.infinity,
                          child: MaterialButton(
                            padding: EdgeInsets.all(12),
                            onPressed: () {
                              currentpassword.clear();
                              confirmpassword.clear();
                              cubit.hidepass1 = true;
                              cubit.hidepass2 = true;

                              cubit.hidepass3 = true;

                              newPassword.clear();
                              showModalBottomSheet(
                                isScrollControlled: true,
                                builder: (context) => StatefulBuilder(
                                  builder: (context, StateSetter setStat) =>
                                      SingleChildScrollView(
                                    padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.7,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(25),
                                          topRight: Radius.circular(25),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Update your Password (:',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontFamily: 'Bakta',
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(15),
                                            child: TextField(
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                              obscureText: cubit.hidepass1,
                                              cursorColor: Colors.black,
                                              controller: currentpassword,
                                              keyboardType: TextInputType.text,
                                              onChanged: (value) {},
                                              onSubmitted: (val) {},
                                              decoration: InputDecoration(
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color:
                                                          Colors.orangeAccent),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  borderSide: BorderSide(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                labelText: 'Current Password',
                                                labelStyle: TextStyle(
                                                    color: Colors.black),
                                                prefixIcon: Icon(
                                                  IconlyBroken.password,
                                                  color: Colors.black,
                                                ),
                                                suffixIcon: MaterialButton(
                                                  onPressed: () {
                                                    cubit
                                                        .changepasswordvisabilty();
                                                  },
                                                  child: Icon(cubit.hidepass1
                                                      ? Icons.remove_red_eye
                                                      : Icons.visibility_off),
                                                ),
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                  color: Colors.black,
                                                )),
                                                disabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(15),
                                            child: TextField(
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                              cursorColor: Colors.black,
                                              controller: newPassword,
                                              obscureText: cubit.hidepass2,
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              onChanged: (value) {},
                                              onSubmitted: (val) {},
                                              decoration: InputDecoration(
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color:
                                                          Colors.orangeAccent),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  borderSide: BorderSide(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                labelText: 'New Password',
                                                labelStyle: TextStyle(
                                                    color: Colors.black),
                                                prefixIcon: Icon(
                                                  Icons.password,
                                                  color: Colors.black,
                                                ),
                                                suffixIcon: MaterialButton(
                                                  onPressed: () {
                                                    cubit
                                                        .changepasswordvisabilty2();
                                                  },
                                                  child: Icon(cubit.hidepass2
                                                      ? Icons.remove_red_eye
                                                      : Icons.visibility_off),
                                                ),
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                  color: Colors.black,
                                                )),
                                                disabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(15),
                                            child: TextField(
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                              cursorColor: Colors.black,
                                              controller: confirmpassword,
                                              keyboardType: TextInputType.text,
                                              onChanged: (value) {},
                                              onSubmitted: (val) {},
                                              obscureText: cubit.hidepass3,
                                              decoration: InputDecoration(
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color:
                                                          Colors.orangeAccent),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  borderSide: BorderSide(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                labelText: 'Confirm Password',
                                                labelStyle: TextStyle(
                                                    color: Colors.black),
                                                prefixIcon: Icon(
                                                  Icons.password,
                                                  color: Colors.black,
                                                ),
                                                suffixIcon: MaterialButton(
                                                  onPressed: () {
                                                    cubit
                                                        .changepasswordvisabilty3();
                                                  },
                                                  child: Icon(cubit.hidepass3
                                                      ? Icons.remove_red_eye
                                                      : Icons.visibility_off),
                                                ),
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                  color: Colors.black,
                                                )),
                                                disabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.black,
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
                                                setState(() {
                                                  cubit.updatePassword(
                                                    currentpassword.text,
                                                    newPassword.text,
                                                    confirmpassword.text,
                                                    token,
                                                    context,
                                                  );
                                                });
                                              },
                                              child: Text(
                                                'Update',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontFamily: 'Bakta',
                                                  fontWeight: FontWeight.w900,
                                                ),
                                              ),
                                              color: Colors.orangeAccent,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                context: context,
                              );
                            },
                            child: Text(
                              'Update Your Password',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Batka',
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'No internet',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Batka',
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.orangeAccent,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            cubit.checkConnecthion();
                            cubit.result ? cubit.getdata(context) : SizedBox();
                          },
                          child: Text(
                            'Retry',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Batka',
                              fontSize: 16,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
        );
      },
    );
  }
}
