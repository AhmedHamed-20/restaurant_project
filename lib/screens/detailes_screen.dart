import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:resturant/models/bloc/cubits/cubit.dart';
import 'package:resturant/models/bloc/states/states.dart';
import 'package:resturant/models/cach/chach.dart';
import 'package:resturant/models/databasae/cart_database.dart';
import 'package:resturant/models/dio/end_points.dart';
import 'package:resturant/widgets/custome_dialog.dart';

class DetailesScreen extends StatelessWidget {
  final String name;
  final String descripthion;
  final String imageurl;
  final String price;
  final int index;
  final List Ingridients;
  final String email;
  final String userId;
  final String recipeId;

  const DetailesScreen({
    this.name,
    this.descripthion,
    this.imageurl,
    this.price,
    this.index,
    this.Ingridients,
    this.email,
    this.userId,
    this.recipeId,
  });

  @override
  Widget build(BuildContext context) {
    var cubit = Appcubit.get(context);
    String token = CachFunc.getData('token');
    TextEditingController addressController = TextEditingController();
    TextEditingController PhoneNumberController = TextEditingController();
    return BlocConsumer<Appcubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Color(0xffFBE7C6),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              'Detailes',
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
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  padding: EdgeInsets.only(top: 10),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(imageurl),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25),
                      topLeft: Radius.circular(25),
                    ),
                  ),
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          name,
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 28,
                            fontFamily: 'Batka',
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(
                          '${price}\$',
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 24,
                            fontFamily: 'Batka',
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(
                          descripthion,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, bottom: 10),
                        child: Column(
                          children: [
                            Text(
                              'Ingridients',
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                fontFamily: 'Batka',
                              ),
                            ),
                            ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: Ingridients.length,
                                itemBuilder: (context, index) {
                                  return Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${index + 1}- ',
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                        Text(
                                          '${Ingridients[index].toString()}',
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                })
                          ],
                        ),
                      ),
                      Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Card(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                        icon: Icon(Icons.remove),
                                        onPressed: () {
                                          cubit.decrementNum();
                                        }),
                                    Text(
                                      cubit.numberOFricipes.toString(),
                                      style: TextStyle(fontFamily: 'Batka'),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.add),
                                      onPressed: () {
                                        cubit.incrementNum();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    cubit.changeLoveIcon();
                                    if (cubit.SearchIntoFavorite(name)) {
                                      cubit.deleteFromFavoriteByName(
                                          name, context);
                                    } else {
                                      cubit.insertIntoFavorite(
                                        imageurl,
                                        name,
                                        price,
                                        email,
                                        descripthion,
                                        userId,
                                        recipeId,
                                      );
                                    }
                                  },
                                  icon: cubit.SearchIntoFavorite(name)
                                      ? Icon(
                                          Icons.favorite,
                                          color: Color(0xfff8d0a1),
                                        )
                                      : cubit.changeLoveIconState
                                          ? Icon(
                                              Icons.favorite,
                                              color: Color(0xfff8d0a1),
                                            )
                                          : Icon(
                                              Icons.favorite_border,
                                              color: Color(0xfff8d0a1),
                                            ))
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Container(
                          width: 250,
                          height: 50,
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            color: Color(0xfff8d0a1),
                            onPressed: () {
                              bool isInside = false;
                              for (int i = 0;
                                  i < EndPoints.FilteredCartDataBase.length;
                                  i++) {
                                print(name + '   hi');
                                print(EndPoints.FilteredCartDataBase[i]
                                    ['recipeName']);
                                if (name ==
                                    EndPoints.FilteredCartDataBase[i]
                                        ['recipeName']) {
                                  isInside = true;
                                  break;
                                } else {
                                  isInside = false;
                                }
                              }
                              if (isInside) {
                                Fluttertoast.showToast(
                                    msg: 'Recipe is in cart',
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white);
                              } else {
                                CartDataBaseFun.insertIntoDataBase(
                                  userId: userId,
                                  recipeName: name,
                                  slug: descripthion,
                                  price: price,
                                  email: email,
                                  photourl: imageurl,
                                  recipeId: recipeId,
                                  amount: cubit.numberOFricipes,
                                );
                              }

                              // cubit.getbyuserid(EndPoints.loginModel.data.user.id,
                              //     CartDataBaseFun.database);
                            },
                            child: Text(
                              'Add To Cart',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Batka',
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Container(
                          width: 250,
                          height: 50,
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            color: Color(0xff7b9c72),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (_) => customeDialog(
                                  addressController,
                                  PhoneNumberController,
                                  context,
                                  recipeId,
                                  token,
                                  cubit.numberOFricipes,
                                  name,
                                  userId,
                                ),
                              );
                            },
                            child: Text(
                              'Order Now',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Batka',
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
