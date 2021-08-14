import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/models/bloc/cubits/cubit.dart';
import 'package:resturant/models/bloc/states/states.dart';

class UserAccount extends StatelessWidget {
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
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Center(
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/pizza.jpg'),
                    radius: 65,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text(
                      'Email: ',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                        fontFamily: 'Batka',
                      ),
                    ),
                    Text(
                      'anaahmedmohamed57@gmail.com',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontFamily: 'Batka',
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
