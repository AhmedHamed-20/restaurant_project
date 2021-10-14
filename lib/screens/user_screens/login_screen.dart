import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:resturant/models/bloc/cubits/login_cubit.dart';
import 'package:resturant/models/bloc/states/login_states.dart';
import 'package:resturant/models/dio/end_points.dart';
import 'package:resturant/screens/user_screens/forget_password_screen.dart';
import 'package:resturant/screens/user_screens/sign_up_screen.dart';
import 'package:resturant/widgets/navigate.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {},
        builder: (context, state) {
          var loginCubit = LoginCubit.get(context);
          loginCubit.checkConnecthion();
          return Scaffold(
            backgroundColor:
                EndPoints.isDark ? Color(0xff222831) : Colors.grey[200],
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/login2.png'),
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.7,
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color:
                            EndPoints.isDark ? Color(0xff393E46) : Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 60,
                              top: 10,
                            ),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 34,
                                fontFamily: 'Batka',
                                fontWeight: FontWeight.w900,
                                color: EndPoints.isDark
                                    ? Colors.white
                                    : EndPoints.isDark
                                        ? Colors.white
                                        : Colors.black,
                              ),
                            ),
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
                            controller: passwordController,
                            keyboardType: TextInputType.text,
                            onChanged: (value) {},
                            onSubmitted: (val) {},
                            obscureText: loginCubit.hidePassword,
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
                              labelText: 'Password',
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    color: Colors.orangeAccent,
                                  )),
                              suffixIcon: MaterialButton(
                                child: loginCubit.hidePassword
                                    ? Icon(
                                        Icons.visibility,
                                        color: Colors.orangeAccent,
                                      )
                                    : Icon(
                                        Icons.visibility_off,
                                        color: Colors.orangeAccent,
                                      ),
                                onPressed: () {
                                  loginCubit.changehidepasswordState();
                                },
                              ),
                              labelStyle: TextStyle(
                                  color: EndPoints.isDark
                                      ? Colors.white
                                      : EndPoints.isDark
                                          ? Colors.white
                                          : Colors.black),
                              prefixIcon: Icon(
                                IconlyBroken.lock,
                                color: EndPoints.isDark
                                    ? Colors.white
                                    : EndPoints.isDark
                                        ? Colors.white
                                        : Colors.black,
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
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              MaterialButton(
                                onPressed: () {
                                  Navigate(
                                      context: context,
                                      Screen: ForgetPassword());
                                },
                                child: Text(
                                  'Forget your password ?',
                                  style: TextStyle(
                                    color: Colors.orangeAccent,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.orangeAccent,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            width: double.infinity,
                            child: MaterialButton(
                              padding: EdgeInsets.all(12),
                              onPressed: () {
                                loginCubit.result
                                    ? loginCubit.login(
                                        emailController.text,
                                        passwordController.text,
                                        context: context,
                                      )
                                    : showDialog(
                                        context: context,
                                        builder: (_) {
                                          return AlertDialog(
                                            backgroundColor: EndPoints.isDark
                                                ? Color(0xff393E46)
                                                : Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            title: Text(
                                              'No internet',
                                              style: TextStyle(
                                                  color: EndPoints.isDark
                                                      ? Colors.white
                                                      : EndPoints.isDark
                                                          ? Colors.white
                                                          : Colors.black),
                                            ),
                                            content: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                color: Colors.orangeAccent,
                                              ),
                                              child: MaterialButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text(
                                                  'OK',
                                                  style: TextStyle(
                                                    color: EndPoints.isDark
                                                        ? Colors.white
                                                        : Colors.white,
                                                    fontSize: 16,
                                                    fontFamily: 'Batka',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        });
                              },
                              child: state is LoginLoadingState
                                  ? Center(
                                      child: Theme(
                                        data: ThemeData(
                                          accentColor: Colors.green,
                                        ),
                                        child: CircularProgressIndicator(
                                          backgroundColor: Color(0xfff8d0a1),
                                        ),
                                      ),
                                    )
                                  : Text(
                                      'Login',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontFamily: 'Batka',
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                            ),
                            //
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'don\'t have account?',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: EndPoints.isDark
                                      ? Colors.white
                                      : Colors.grey[800],
                                ),
                              ),
                              MaterialButton(
                                onPressed: () {
                                  Navigate(
                                    context: context,
                                    Screen: SignUpScreen(),
                                  );
                                },
                                child: Text(
                                  'SignUp',
                                  style: TextStyle(
                                    color: Colors.orangeAccent,
                                    fontSize: 16,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
