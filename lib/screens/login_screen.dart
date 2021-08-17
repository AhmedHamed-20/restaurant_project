import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/layouts/layout_screen.dart';
import 'package:resturant/models/bloc/cubits/cubit.dart';
import 'package:resturant/models/bloc/states/states.dart';
import 'package:resturant/screens/sign_up_screen.dart';
import 'package:resturant/widgets/navigate.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Appcubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
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
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextField(
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          textDirection: TextDirection.rtl,
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
                              Icons.email,
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
                          textDirection: TextDirection.rtl,
                          cursorColor: Colors.black,
                          controller: passwordController,
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
                              Icons.lock,
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
                              Navigate(
                                context: context,
                                Screen: LayoutScreen(),
                              );
                            },
                            child: Text(
                              'Login',
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
