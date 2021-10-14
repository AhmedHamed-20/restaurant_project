import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:resturant/models/bloc/cubits/cubit.dart';
import 'package:resturant/models/bloc/states/states.dart';
import 'package:resturant/models/dio/end_points.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = Appcubit.get(context);
    TextEditingController emailController = TextEditingController();
    return BlocConsumer<Appcubit, AppState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor:
                EndPoints.isDark ? Color(0xff222831) : Colors.grey[200],
            appBar: AppBar(
              leading: MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: EndPoints.isDark
                      ? Colors.white
                      : EndPoints.isDark
                          ? Colors.white
                          : Colors.black,
                ),
              ),
              title: Text(
                'Forget Password',
                style: TextStyle(
                    color: EndPoints.isDark
                        ? Colors.white
                        : EndPoints.isDark
                            ? Colors.white
                            : Colors.black,
                    fontFamily: 'Batka'),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/forget.png',
                    width: 200,
                    height: 200,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color:
                          EndPoints.isDark ? Color(0xff393E46) : Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25),
                        topLeft: Radius.circular(25),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Enter your email',
                          style: TextStyle(
                              fontSize: 22,
                              fontFamily: 'Batka',
                              fontWeight: FontWeight.w900,
                              color: EndPoints.isDark
                                  ? Colors.white
                                  : EndPoints.isDark
                                      ? Colors.white
                                      : Colors.black),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          style: TextStyle(
                            color: EndPoints.isDark
                                ? Colors.white
                                : EndPoints.isDark
                                    ? Colors.white
                                    : Colors.black,
                          ),
                          cursorColor: EndPoints.isDark
                              ? Colors.white
                              : EndPoints.isDark
                                  ? Colors.white
                                  : Colors.black,
                          controller: emailController,
                          keyboardType: TextInputType.text,
                          onChanged: (value) {},
                          onSubmitted: (val) {},
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: EndPoints.isDark
                                    ? Colors.white
                                    : EndPoints.isDark
                                        ? Colors.white
                                        : Colors.black,
                              ),
                            ),
                            labelText: 'Email',
                            labelStyle: TextStyle(
                                color: EndPoints.isDark
                                    ? Colors.white
                                    : EndPoints.isDark
                                        ? Colors.white
                                        : Colors.black),
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: EndPoints.isDark
                                  ? Colors.white
                                  : EndPoints.isDark
                                      ? Colors.white
                                      : Colors.black,
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Colors.orangeAccent,
                                )),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: EndPoints.isDark
                                      ? Colors.white
                                      : EndPoints.isDark
                                          ? Colors.white
                                          : Colors.black,
                                )),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: EndPoints.isDark
                                    ? Colors.white
                                    : EndPoints.isDark
                                        ? Colors.white
                                        : Colors.black,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            color: Colors.orangeAccent,
                            onPressed: () {
                              if (emailController.text.isEmpty) {
                                Fluttertoast.showToast(
                                  msg: 'please enter your mail',
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                );
                              } else {
                                cubit.forgetPassword(
                                  emailController.text.trim(),
                                );
                              }
                            },
                            child: Text(
                              'Forget',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
