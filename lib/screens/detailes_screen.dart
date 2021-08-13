import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/models/bloc/cubits/cubit.dart';
import 'package:resturant/models/bloc/states/states.dart';

class DetailesScreen extends StatelessWidget {
  final String name;
  final String descripthion;
  final String imageurl;
  final String price;
  final int index;

  const DetailesScreen(
      {this.name, this.descripthion, this.imageurl, this.price, this.index});

  @override
  Widget build(BuildContext context) {
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
                              image: AssetImage('assets/images/pizza.jpg'),
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
                      'Pizza',
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
                      '\$5',
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
                  Text(
                    'Pizza (Italian: [ˈpittsa], Neapolitan: [ˈpittsə]) is an Italian dish consisting of a usually round',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, bottom: 10),
                    child: Text(
                      'Ingridients',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Batka',
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 130,
                      child: Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                icon: Icon(Icons.remove), onPressed: () {}),
                            Text('0'),
                            IconButton(icon: Icon(Icons.add), onPressed: () {}),
                          ],
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
                        color: Colors.red[300],
                        onPressed: () {},
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
