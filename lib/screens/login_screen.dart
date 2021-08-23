import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:resturant/layouts/layout_screen.dart';
import 'package:resturant/models/bloc/cubits/cubit.dart';
import 'package:resturant/models/bloc/cubits/login_cubit.dart';
import 'package:resturant/models/bloc/states/login_states.dart';
import 'package:resturant/models/bloc/states/states.dart';
import 'package:resturant/screens/sign_up_screen.dart';
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
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 34,
                          fontFamily: 'Bakta',
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.3,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextField(
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            cursorColor: Colors.black,
                            controller: emailController,
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
                            height: 10,
                          ),
                          TextField(
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            cursorColor: Colors.black,
                            controller: passwordController,
                            keyboardType: TextInputType.text,
                            onChanged: (value) {},
                            onSubmitted: (val) {},
                            obscureText: loginCubit.hidePassword,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              labelText: 'Password',
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
                            height: 10,
                          ),
                          Container(
                            width: double.infinity,
                            child: MaterialButton(
                                padding: EdgeInsets.all(12),
                                onPressed: () {
                                  loginCubit.login(
                                    emailController.text,
                                    passwordController.text,
                                    context: context,
                                    screen: LayoutScreen(),
                                  );
                                },
                                child: state is LoginLoadingState
                                    ? Center(
                                        child: Theme(
                                          data: ThemeData(
                                            accentColor: Colors.green,
                                          ),
                                          child: CircularProgressIndicator(
                                            backgroundColor:
                                                Colors.orangeAccent,
                                          ),
                                        ),
                                      )
                                    : Text(
                                        'Login',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontFamily: 'Bakta',
                                          fontWeight: FontWeight.w900,
                                        ),
                                      )),
                            color: Colors.orangeAccent,
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
                                  color: Colors.grey[800],
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
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
