import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:resturant/layouts/user_layout/user_layout_screen.dart';
import 'package:resturant/models/bloc/cubits/sign_up_cubit.dart';
import 'package:resturant/models/bloc/states/sign_up_states.dart';
import 'package:resturant/models/dio/end_points.dart';
import 'package:resturant/screens/user_screens/login_screen.dart';
import 'package:resturant/widgets/navigate.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController UserName = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController passwordConfirmController = TextEditingController();
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: BlocConsumer<SignUpCubit, SignUpState>(
        listener: (context, state) {},
        builder: (context, state) {
          var signUpcubit = SignUpCubit.get(context);
          signUpcubit.checkConnecthion();
          return Scaffold(
            backgroundColor:
                EndPoints.isDark ? Color(0xff222831) : Colors.grey[200],
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
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
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color:
                            EndPoints.isDark ? Color(0xff393E46) : Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 20,
                            ),
                            child: Text(
                              'Sign Up',
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
                                  : Colors.black,
                            ),
                            cursorColor: EndPoints.isDark
                                ? Colors.white
                                : EndPoints.isDark
                                    ? Colors.white
                                    : Colors.black,
                            controller: UserName,
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
                                  color: EndPoints.isDark
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              labelText: 'User Name',
                              labelStyle: TextStyle(
                                  color: EndPoints.isDark
                                      ? Colors.white
                                      : Colors.black),
                              prefixIcon: Icon(
                                IconlyBroken.profile,
                                color: EndPoints.isDark
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: EndPoints.isDark
                                    ? Colors.white
                                    : Colors.black,
                              )),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: EndPoints.isDark
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextField(
                            style: TextStyle(
                              color: EndPoints.isDark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            cursorColor:
                                EndPoints.isDark ? Colors.white : Colors.black,
                            controller: emailController,
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
                                  color: EndPoints.isDark
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                  color: EndPoints.isDark
                                      ? Colors.white
                                      : Colors.black),
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: EndPoints.isDark
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: EndPoints.isDark
                                    ? Colors.white
                                    : Colors.black,
                              )),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: EndPoints.isDark
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextField(
                            style: TextStyle(
                              color: EndPoints.isDark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            cursorColor:
                                EndPoints.isDark ? Colors.white : Colors.black,
                            controller: passwordController,
                            keyboardType: TextInputType.text,
                            onChanged: (value) {},
                            onSubmitted: (val) {},
                            obscureText: signUpcubit.hidePassword1,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    color: Colors.orangeAccent,
                                  )),
                              suffixIcon: MaterialButton(
                                child: signUpcubit.hidePassword1
                                    ? Icon(
                                        Icons.visibility,
                                        color: Colors.orangeAccent,
                                      )
                                    : Icon(
                                        Icons.visibility_off,
                                        color: Colors.orangeAccent,
                                      ),
                                onPressed: () {
                                  signUpcubit.changehidepasswordState();
                                },
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: EndPoints.isDark
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                  color: EndPoints.isDark
                                      ? Colors.white
                                      : Colors.black),
                              prefixIcon: Icon(
                                IconlyBroken.lock,
                                color: EndPoints.isDark
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    color: EndPoints.isDark
                                        ? Colors.white
                                        : Colors.black,
                                  )),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: EndPoints.isDark
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextField(
                            style: TextStyle(
                              color: EndPoints.isDark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            cursorColor:
                                EndPoints.isDark ? Colors.white : Colors.black,
                            controller: passwordConfirmController,
                            keyboardType: TextInputType.text,
                            onChanged: (value) {},
                            onSubmitted: (val) {},
                            obscureText: signUpcubit.hidePassword2,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    color: Colors.orangeAccent,
                                  )),
                              suffixIcon: MaterialButton(
                                child: signUpcubit.hidePassword2
                                    ? Icon(
                                        Icons.visibility,
                                        color: Colors.orangeAccent,
                                      )
                                    : Icon(
                                        Icons.visibility_off,
                                        color: Colors.orangeAccent,
                                      ),
                                onPressed: () {
                                  signUpcubit.changehidepasswordState2();
                                },
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: EndPoints.isDark
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              labelText: 'Confirm Password',
                              labelStyle: TextStyle(
                                  color: EndPoints.isDark
                                      ? Colors.white
                                      : Colors.black),
                              prefixIcon: Icon(
                                IconlyBroken.lock,
                                color: EndPoints.isDark
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: EndPoints.isDark
                                    ? Colors.white
                                    : Colors.black,
                              )),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: EndPoints.isDark
                                      ? Colors.white
                                      : Colors.black,
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
                                signUpcubit.result
                                    ? signUpcubit.SignUp(
                                        UserName.text,
                                        emailController.text,
                                        passwordController.text,
                                        passwordConfirmController.text,
                                        context: context,
                                        screen: LayoutScreen(),
                                      )
                                    : showDialog(
                                        context: context,
                                        builder: (_) {
                                          return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            title: Text('No internet'),
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
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontFamily: 'Batka',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        });
                              },
                              child: state is SignUpLoadingState
                                  ? Center(
                                      child: Theme(
                                        data: ThemeData(
                                          accentColor: Colors.green,
                                        ),
                                        child: CircularProgressIndicator(
                                          backgroundColor: Colors.orangeAccent,
                                        ),
                                      ),
                                    )
                                  : Text(
                                      'Sign Up',
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
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'have account?',
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
                                    Screen: LoginScreen(),
                                  );
                                },
                                child: Text(
                                  'LogIn',
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
