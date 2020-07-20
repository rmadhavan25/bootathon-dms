import 'dart:developer';
import 'dart:io';
import 'userHome.dart';
import 'doctorHome.dart';
import 'chooseToRegister.dart';
import 'design.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _userLoginKey = GlobalKey<FormState>();
  @override


  FlatButton setLoginButton(String action)
  {
    return FlatButton(
      onPressed: () {
        if(action=='Sign in')
        {
          if(_userLoginKey.currentState.validate()){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DoctorHomePage()),
            );
          }
        }
        else{
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChooseToRegister()),
          );
        }
      },
      child: Container(
        color: Colors.black,
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
        child: Text(
          action,
          style: TextStyle(
            letterSpacing: 1,
            color: Colors.white,
            fontSize: 12,
            fontFamily: 'Bangers',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
  Design login = new Design();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _userLoginKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Tab(
                      icon: Image.asset('images/medical-record.png'),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    login.setLoginFormField('email@example.com',r'^(\w)+@[a-z]+.com$','email'),
                    SizedBox(
                      height: 40,
                    ),
                    login.setLoginFormField('Enter your password', r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$', 'password'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        setLoginButton('Register'),
                        setLoginButton('Sign in'),
                      ],
                    )//buttons
                  ],
                ),//loginFields
              ),
            ),
          ),
        ),
      ),
    );
  }
}