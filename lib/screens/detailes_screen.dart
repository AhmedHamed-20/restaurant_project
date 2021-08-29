import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:resturant/models/bloc/cubits/cubit.dart';
import 'package:resturant/models/bloc/states/states.dart';
import 'package:resturant/models/cach/chach.dart';
import 'package:resturant/models/databasae/cart_database.dart';
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
          appBar: AppBar(
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
            child: Padding(
              padding: const EdgeInsets.only(
                left: 12,
                right: 12,
                top: 12,
                bottom: 12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 350,
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.green[100],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(imageurl),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      name,
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 28,
                        fontFamily: 'Bakta',
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
                        fontFamily: 'Bakta',
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
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                    icon: Icon(Icons.remove),
                                    onPressed: () {
                                      cubit.decrementNum();
                                    }),
                                Text(
                                  cubit.numberOFricipes.toString(),
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
                              onPressed: () {},
                              icon: Icon(Icons.favorite_border))
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
                        color: Colors.red[300],
                        onPressed: () {
                          bool isInside = false;
                          for (int i = 0;
                              i < CartDataBaseFun.CartAndFavorite.length;
                              i++) {
                            if (name ==
                                CartDataBaseFun.CartAndFavorite[i]
                                    ['recipeName']) {
                              isInside = true;
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
                            fontFamily: 'Bakta',
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
                        color: Colors.lightGreen,
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
                            ),
                          );
                        },
                        child: Text(
                          'Order Now',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'Bakta',
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
        );
      },
    );
  }
}
