import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:resturant/models/bloc/cubits/cubit.dart';
import 'package:resturant/models/bloc/states/states.dart';
import 'package:resturant/screens/login_screen.dart';
import 'package:resturant/widgets/navigate.dart';

class UserAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailcontroller = TextEditingController();
    TextEditingController userName = TextEditingController();
    TextEditingController password = TextEditingController();
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
            padding: const EdgeInsets.all(20),
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
                TextField(
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  textDirection: TextDirection.rtl,
                  cursorColor: Colors.black,
                  controller: userName,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {},
                  onSubmitted: (val) {},
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
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
                        borderSide: BorderSide(
                      color: Colors.black,
                    )),
                    disabledBorder: OutlineInputBorder(
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
                  textDirection: TextDirection.rtl,
                  cursorColor: Colors.black,
                  controller: emailcontroller,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {},
                  onSubmitted: (val) {},
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
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
                        borderSide: BorderSide(
                      color: Colors.black,
                    )),
                    disabledBorder: OutlineInputBorder(
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
                  textDirection: TextDirection.rtl,
                  cursorColor: Colors.black,
                  controller: password,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {},
                  onSubmitted: (val) {},
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.black),
                    prefixIcon: Icon(
                      IconlyBroken.lock,
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.black,
                    )),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: double.infinity,
                  child: MaterialButton(
                    padding: EdgeInsets.all(12),
                    onPressed: () {},
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
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: double.infinity,
                  child: MaterialButton(
                    padding: EdgeInsets.all(12),
                    onPressed: () {
                      Navigate(Screen: LoginScreen(), context: context);
                    },
                    child: Text(
                      'LogOut',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Bakta',
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    color: Colors.orangeAccent,
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
