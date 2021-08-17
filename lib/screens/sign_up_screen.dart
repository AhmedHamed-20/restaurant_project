import 'package:flutter/material.dart';
import 'package:resturant/layouts/layout_screen.dart';
import 'package:resturant/screens/login_screen.dart';
import 'package:resturant/widgets/navigate.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController UserName = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
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
                          Icons.person,
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
                      height: 15,
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
                      height: 15,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
