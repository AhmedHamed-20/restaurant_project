import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:resturant/models/bloc/cubits/cubit.dart';
import 'package:resturant/models/bloc/states/states.dart';
import 'package:resturant/models/cach/chach.dart';
import 'package:resturant/models/databasae/cart_database.dart';
import 'package:resturant/models/dio/end_points.dart';
import 'package:resturant/widgets/bottomSheetContent.dart';

class DetailesScreen extends StatelessWidget {
  final String name;
  final String descripthion;
  final String imageurl;
  final int price;
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
  Widget build(BuildContext context1) {
    var cubit = Appcubit.get(context1);
    String token = CachFunc.getData('token');
    TextEditingController addressController = TextEditingController();
    TextEditingController PhoneNumberController = TextEditingController();
    final scaffoldState = GlobalKey<ScaffoldState>();
    return BlocConsumer<Appcubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          key: scaffoldState,
          appBar: AppBar(
            leading: MaterialButton(
              onPressed: () {
                Navigator.of(context).pop();
                cubit.numberOFricipes = 1;
              },
              child: Icon(Icons.arrow_back_ios),
            ),
            backgroundColor: Colors.transparent,
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
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(imageurl),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // borderRadius: BorderRadius.only(
                    //   topRight: Radius.circular(25),
                    //   topLeft: Radius.circular(25),
                    // ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15),
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
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 15,
                              bottom: 10,
                              top: 10,
                              right: 15,
                            ),
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
                                StaggeredGridView.countBuilder(
                                  shrinkWrap: true,
                                  mainAxisSpacing: 10,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: Ingridients.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      elevation: 3,
                                      child: Container(
                                        width: 120,
                                        margin: EdgeInsets.all(10),
                                        child: Text(
                                          '${Ingridients[index].toString()}',
                                          textAlign: TextAlign.center,
                                          softWrap: true,
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  staggeredTileBuilder: (int index) =>
                                      StaggeredTile.fit(1),
                                  crossAxisCount: 2,
                                )
                              ],
                            ),
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
                                      if (cubit.SearchIntoFavorite(name)) {
                                        cubit.deleteFromFavoriteByName(
                                            name, context);
                                      } else {
                                        cubit.insertIntoFavorite(
                                          imageurl,
                                          name,
                                          price.toString(),
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
                                scaffoldState.currentState.showBottomSheet(
                                  (context1) => bottomSheetContent(
                                    context: context1,
                                    isAll: false,
                                    recipeName: name,
                                    isEnabled: true,
                                    addressController: addressController,
                                    PhoneNumberController:
                                        PhoneNumberController,
                                    userId: userId,
                                    token: token,
                                    title: 'We need this data (:',
                                    buttonTitle: 'Order Now',
                                    textfield1Icon: Icons.add_location,
                                    textfield2Icon: Icons.phone,
                                    textfield1Title: 'Address',
                                    textfield2Title: 'Phone Number',
                                    isOrder: true,
                                    orders: [
                                      {
                                        'recipeId': '${recipeId}',
                                        'amount': cubit.numberOFricipes,
                                      },
                                    ],
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
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
