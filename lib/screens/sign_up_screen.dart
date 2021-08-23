import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:resturant/layouts/layout_screen.dart';
import 'package:resturant/models/bloc/cubits/sign_up_cubit.dart';
import 'package:resturant/models/bloc/states/sign_up_states.dart';
import 'package:resturant/screens/login_screen.dart';
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
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 34,
                          fontFamily: 'Bakta',
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.2,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextField(
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            cursorColor: Colors.black,
                            controller: UserName,
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
                            height: 15,
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
                            obscureText: signUpcubit.hidePassword1,
                            decoration: InputDecoration(
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
                          TextField(
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            cursorColor: Colors.black,
                            controller: passwordConfirmController,
                            keyboardType: TextInputType.text,
                            onChanged: (value) {},
                            onSubmitted: (val) {},
                            obscureText: signUpcubit.hidePassword2,
                            decoration: InputDecoration(
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
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              labelText: 'Confirm Password',
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
                              onPressed: () {
                                signUpcubit.SignUp(
                                  UserName.text,
                                  emailController.text,
                                  passwordController.text,
                                  passwordConfirmController.text,
                                  context: context,
                                  screen: LayoutScreen(),
                                );
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
                                        fontFamily: 'Bakta',
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                              color: Colors.orangeAccent,
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
                                  color: Colors.grey[800],
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
