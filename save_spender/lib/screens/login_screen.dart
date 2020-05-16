import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:connectivity/connectivity.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:encrypt/encrypt.dart';
import '../screens/main_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool passwordVisible;

  @override
  void initState() {
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/akmal.jpg"), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                      child:Text('Save Spender',
                        style: TextStyle(
                            fontSize: 50.0,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Roboto',
                            color: Colors.white
                        ),)),

                  SizedBox(
                    height: 15.0,
                  ),


                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
                    child: Container(
                      width: 300.0,
                      child: TextFormField(
                        maxLines: 1,
                        keyboardType: TextInputType.text,
                        autofocus: false,
                        decoration: InputDecoration(
                            enabledBorder: new OutlineInputBorder(
                                borderSide: new BorderSide(color: Colors.white)
                            ),
                            focusedBorder: new OutlineInputBorder(
                                borderSide: new BorderSide(color: Colors.white)
                            ),
                            hintText: 'Username',
                            prefixIcon: new Icon(
                                Icons.account_circle,
                                color: Colors.white
                            ),
                            hintStyle: TextStyle(
                                color: Colors.white
                            )
                        ),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                        controller: usernameController,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                    child: Container(
                      width: 300.0,
                      child: TextFormField(
                        maxLines: 1,
                        autofocus: false,
                        obscureText: passwordVisible,
                        decoration: InputDecoration(
                          enabledBorder: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white)
                          ),
                          focusedBorder: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white)
                          ),
                          hintText: 'Password',
                          prefixIcon: new Icon(
                              Icons.lock,
                              color: Colors.white
                          ),
                          hintStyle: TextStyle(
                              color: Colors.white
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              passwordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              // Update the state i.e. toogle the state of passwordVisible variable
                              setState(() {
                                passwordVisible = !passwordVisible;
                              });
                            },
                          ),
                        ),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                        controller: passwordController,

                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
                    child: Container(
                      width: 300.0,
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () async {
                          String username = usernameController.text;
                          String password = passwordController.text;

                          
                          //var sessToken = await LoginModel().getToken(username, password);

                          if(username == 'demo' && password =='demo'){ //print('hello');}
                            Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => MainScreen()));}
                          else{
                            //showIncorrectInfoFlushbar(context);
                            print('no');
                          }
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF53C759)
                          ),
                          textAlign: TextAlign.center,
                        ),
                        color: Colors.white,
                      ),
                    ),
                  ),

                  // Padding(
                  //   padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                  //   child: Container(
                  //     width: 300.0,
                  //     height: 40.0,
                  //     child: FlatButton(
                  //       onPressed: () async {

                  //         Navigator.push(context, CupertinoPageRoute(builder: (context) => ForgotScreen()));
                  //       },
                  //       child: Text(
                  //         'FORGOT PASSWORD?',
                  //         style: TextStyle(
                  //             fontSize: 20.0,
                  //             fontFamily: 'Roboto',
                  //             fontWeight: FontWeight.w700,
                  //             color: Colors.white
                  //         ),
                  //         textAlign: TextAlign.center,
                  //       ),
                  //     ),
                  //   ),
                  // )
                ],
              )
          ),
        ),
      ),
    );
  }

  Widget loadingView() => Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.green,
      ),
    );

  // void showIncorrectInfoFlushbar(BuildContext context) {
  //   Flushbar(
  //     title: 'Wrong Credentials!',
  //     message: 'Please try again.',
  //     icon: Icon(
  //       Icons.info_outline,
  //       size: 28,
  //       color: Color(0xFF53C759),
  //     ),
  //     leftBarIndicatorColor: Color(0xFF53C759),
  //     duration: Duration(seconds: 3),
  //   )..show(context);
  // }



}